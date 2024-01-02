# Additional Set-up Instructions & Troubleshooting: Windows

#### **VS Code Terminal: Change default from Powershell to Git Bash**

Add the following to User settings.json for VS Code

```json
"terminal.integrated.shell.windows": "C:\\Program Files\\Git\\bin\\bash.exe"
```
Where:
- The path `"C:\\Program Files\\Git\\bin\\bash.exe"` should be the path for your bash terminal executable. Path is dependent on where git bash is installed. 

#### **Java: Add to environment variables**

1. In Search, search for and then select: Edit env
2. Environment Variables window should open
3. In the section **System Variables** find the `PATH` environment variable and select it. Click Edit. If the `PATH` environment variable does not exist, click New.
4. In the **Edit System Variable** (or **New System Variable**) window, specify the value of the `PATH` environment variable. (The path would look something like this if you are using Oracle JDK: `C:\Program Files\Java\jdk1.8.0_291\bin` Path is dependent on where JDK is installed or extracted) 
5. Click OK. Close all remaining windows by clicking OK.
6. Restart or re-open any command prompt / powershell / git bash terminals that you have open

#### **Troubleshooting: selenium-standalone Installation**

For some reason, some windows laptops are not able to properly install selenium-standalone drivers and jar using the command below:

```bash
NODE_TLS_REJECT_UNAUTHORIZED=0 ./node_modules/.bin/selenium-standalone install --config=./selenium.json
```

Error Message when installing/downloading binaries:
```bash
Error: end of central directory record signature not found
```

To fix this issue:

1.  *You can disconnect from PVH VPN and try the command again*. It should work fine.

2. The other workaround is to manually download and replace the binaries in the folder for each item `.\node_modules\selenium-standalone\.selenium`
This would however mean that any future update of the driver versions would also have to be done manually. **THIS WORKAROUND IS NOT RECOMMENDED** and only meant as last resort.