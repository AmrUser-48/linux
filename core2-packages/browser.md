# Compiling Brave Browser in GitHub Codespaces

This guide provides a precise, resource-optimized roadmap for compiling the Brave Browser inside a headless Linux GitHub Codespace environment (Gentoo/Debian base). It addresses the structural limitations of the free tier container—specifically **storage boundaries (64 GB)**, **RAM constraints (16 GB)**, and the **24-hour runtime / 30-minute idle session timeouts**.

---

## ⚠️ Pre-Requisites & Constraints

| Resource | Free Tier Constraint | Requirement / Mitigation |
| :--- | :--- | :--- |
| **Storage** | 64 GB baseline | **Insufficient for Full Release.** Must compile a minimal developer footprint using `is_component_build = true` and `symbol_level = 0`. |
| **Memory** | 16 GB RAM | High risk of Out-Of-Memory (OOM) compilation crashes. **Must configure an 8 GB virtual swap space.** |
| **Idle Timeout** | 30 minutes of user inactivity | The container shuts down if no inputs are detected. **Must use a cloud multiplexer loop.** |
| **Session Cap** | 24 hours max continuous runtime | A single running session is forcefully stopped after 24 hours. |

---

## 🛠️ Execution Roadmap

### Step 1: Initialize Virtual Memory (Swap Space)
To prevent the Linux OOM killer from terminating the compiler during heavy link-time processes, allocate an 8 GB swapfile within your workspace:

```bash
sudo fallocate -l 8G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
```

### Step 2: Clone and Synchronize Codebase
Clone Brave's build infrastructure repository and initialize the downstream sub-modules (including the massive Chromium engine footprint). *Note: The initial sync can take up to 45 minutes.*

```bash
git clone https://github.com
cd brave-browser
npm install
npm run init
```

### Step 3: Optimize Build Configuration Flags
To fit within the storage space, edit your active build environment configuration arguments (e.g., `src/out/Debug/args.gn`) or your Portage environment flags to enforce lightweight, modular component builds:

```gn
is_component_build = true
symbol_level = 0
```
* **`is_component_build = true`**: Splits the monolithic browser binary into hundreds of small shared libraries (`.so`). If the codespace disconnects, progress safely pauses and can be resumed incrementally without starting from scratch.
* **`symbol_level = 0`**: Completely strips debugging symbols, shrinking disk space demands to fit on standard drives.

### Step 4: Configure for Unattended Overnight Building
Because a codespace shuts down 30 minutes after you turn off your physical laptop, you must isolate the build inside a detached screen session on GitHub's cloud servers, accompanied by a simulated activity loop.

1. **Install and spin up a detached screen container:**
   ```bash
   sudo emerge --ask app-misc/screen   # For Gentoo environments
   # OR: sudo apt-get install screen   # For Ubuntu/Debian variations
   
   screen -S overnight_build
   ```

2. **Execute the self-sustaining build process:**
   Run the following combined command string inside your screen terminal. The background loop appends an internal file system timestamp every 5 minutes, preventing the container from identifying the machine as idle:
   ```bash
   (while true; do echo "Keepalive file tick: \$(date)" >> keepalive.log; sleep 300; done) & \
   npm run build
   ```

3. **Safely detach and power down your local machine:**
   * Press `Ctrl + A`, then immediately press `D` on your keyboard.
   * The terminal will output `[detached from overnight_build]`.
   * **You can now safely close your browser tab, shut down your physical machine, and walk away.**

---

## 📊 Re-attaching & Monitoring Usage

When you re-authenticate the following morning, launch your codespace and execute these checking sequences:

* **Re-attach to your active build environment:**
  ```bash
  screen -r overnight_build
  ```
* **Verify your remaining monthly free tier quotas:**
  ```bash
  gh api user/billing/codespaces -q '.total_minutes_used'
  ```
