#define _FILE_OFFSET_BITS 64
#include <zlib.h>

#include <limits.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static unsigned char *read_file(const char *path, size_t *size_out) {
    FILE *file = fopen(path, "rb");
    long size;
    unsigned char *buffer;

    if (file == NULL) {
        perror(path);
        return NULL;
    }
    if (fseek(file, 0, SEEK_END) != 0 || (size = ftell(file)) < 0 ||
        fseek(file, 0, SEEK_SET) != 0) {
        perror("file size/rewind");
        fclose(file);
        return NULL;
    }
    buffer = (unsigned char *)malloc(size > 0 ? (size_t)size : 1);
    if (buffer == NULL) {
        fprintf(stderr, "out of memory reading %s\n", path);
        fclose(file);
        return NULL;
    }
    if (size > 0 && fread(buffer, 1, (size_t)size, file) != (size_t)size) {
        perror("read");
        free(buffer);
        fclose(file);
        return NULL;
    }
    fclose(file);
    *size_out = (size_t)size;
    return buffer;
}

static int compress_file(const char *path) {
    size_t input_size = 0;
    unsigned char *input = read_file(path, &input_size);
    unsigned char *compressed;
    uLongf compressed_size;
    unsigned char header[8];
    int result;
    size_t i;

    if (input == NULL)
        return 1;
    if ((size_t)(uLong)input_size != input_size) {
        fprintf(stderr, "input too large for zlib API\n");
        free(input);
        return 1;
    }

    compressed_size = compressBound((uLong)input_size);
    compressed = (unsigned char *)malloc((size_t)compressed_size);
    if (compressed == NULL) {
        fprintf(stderr, "out of memory allocating compressed buffer\n");
        free(input);
        return 1;
    }

    result = compress2(compressed, &compressed_size, input, (uLong)input_size, Z_DEFAULT_COMPRESSION);
    if (result != Z_OK) {
        fprintf(stderr, "compress2 failed: %d\n", result);
        free(compressed);
        free(input);
        return 1;
    }

    for (i = 0; i < sizeof(header); i++)
        header[7 - i] = (unsigned char)(((uint64_t)input_size >> (i * 8)) & 0xff);

    if (fwrite(header, 1, sizeof(header), stdout) != sizeof(header) ||
        fwrite(compressed, 1, (size_t)compressed_size, stdout) != (size_t)compressed_size) {
        perror("write compressed stream");
        free(compressed);
        free(input);
        return 1;
    }

    free(compressed);
    free(input);
    return 0;
}

static int decompress_file(const char *path) {
    size_t archive_size = 0;
    unsigned char *archive = read_file(path, &archive_size);
    uint64_t original_size = 0;
    unsigned char *output;
    uLongf output_size;
    uLong compressed_size;
    int result;
    size_t i;

    if (archive == NULL)
        return 1;
    if (archive_size < 8) {
        fprintf(stderr, "compressed stream is truncated\n");
        free(archive);
        return 1;
    }
    for (i = 0; i < 8; i++)
        original_size = (original_size << 8) | archive[i];

    if (original_size > SIZE_MAX || original_size > ULONG_MAX ||
        archive_size - 8 > ULONG_MAX) {
        fprintf(stderr, "compressed stream exceeds zlib API limits\n");
        free(archive);
        return 1;
    }

    output_size = (uLongf)original_size;
    compressed_size = (uLong)(archive_size - 8);
    output = (unsigned char *)malloc(original_size > 0 ? (size_t)original_size : 1);
    if (output == NULL) {
        fprintf(stderr, "out of memory allocating decompressed buffer\n");
        free(archive);
        return 1;
    }

    result = uncompress(output, &output_size, archive + 8, compressed_size);
    if (result != Z_OK || output_size != (uLongf)original_size) {
        fprintf(stderr, "uncompress failed: %d\n", result);
        free(output);
        free(archive);
        return 1;
    }

    if (fwrite(output, 1, (size_t)output_size, stdout) != (size_t)output_size) {
        perror("write decompressed stream");
        free(output);
        free(archive);
        return 1;
    }

    free(output);
    free(archive);
    return 0;
}

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s compress INPUT | decompress ARCHIVE\n", argv[0]);
        return 2;
    }
    if (strcmp(argv[1], "compress") == 0)
        return compress_file(argv[2]);
    if (strcmp(argv[1], "decompress") == 0)
        return decompress_file(argv[2]);

    fprintf(stderr, "Unknown operation: %s\n", argv[1]);
    return 2;
}
