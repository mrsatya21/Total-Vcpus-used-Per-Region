# Total-Vcpus-used-Per-Region
This bash script can be used to find out the total number of VCpus used in the region where any EC2 instance is running or stopped. 

### Only to be used in AWS CLOUD

#### This is a Shell Script, that can be used to find out the total VCpu used in all the regions. 

It sometimes becomes tricky to find out the number of VCpus consumed in any given region and due to this, you may get the error VCpu limit exhausted while launching an EC2 instance. You can make use of this script to find out the total consumed VCpus in any region.

1. Download or [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository#cloning-a-repository) the script from github repository.

    ```sh
    $ git clone https://github.com/mrsatya21/Total-Vcpus-used-Per-Region.git
    ```
2. Go to the directory Total-Vcpus-used-Per-Region where you have downloaded or cloned the repository. 

    ```sh
    cd Total-Vcpus-used-Per-Region
    ```

3. Change the permission - 

    ```sh
    chmod +x total_VCpu_Per_Region.sh 
    ```

4. Run the shell script - 

    ```sh
    ./total_VCpu_Per_Region.sh 
    ```

NOTE - It is necessary to [install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and [configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods) AWS [CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-welcome.html) before using this script.
