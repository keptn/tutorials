

## Download Keptn CLI
Duration: 3:00

Every release of Keptn provides binaries for the Keptn CLI. These binaries are available for Linux, macOS, and Windows.

There are multiple options how to get the Keptn CLI on your machine.

- Easiest option (works Linux, Mac OS, Windows with Bash, WSL2): 

    <!-- command -->
    ```
    curl -sL https://get.keptn.sh | KEPTN_VERSION=0.8.4 bash
    ```
    This will download and install the Keptn CLI in the specified version automatically.

- Using HomeBrew (on MacOs):

    ```
    brew install keptn
    ```

-  Another option is to manually download the current release of the Keptn CLI:
  1. Download the version for your operating system and architecture from [Download CLI](https://github.com/keptn/keptn/releases/tag/0.8.4)
  2. Unpack the download
  3. Find the `keptn` binary (e.g., `keptn-0.8.4-amd64.exe`) in the unpacked directory and rename it to `keptn`
    - *Linux / macOS*: Add executable permissions (``chmod +x keptn``), and move it to the desired destination (e.g. `mv keptn /usr/local/bin/keptn`)

    - *Windows*: Copy the executable to the desired folder and add the executable to your PATH environment variable.


Now, you should be able to run the Keptn CLI: 
- Linux / macOS

    <!-- debug -->
    ```
    keptn --help
    ```

- Windows
    ```
    .\keptn.exe --help
    ```

Positive
: For the rest of the documentation we will stick to the *Linux / macOS* version of the commands.

