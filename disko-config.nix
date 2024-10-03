{
  disko.devices = {
	disk = {
	    my-disk = {
	      device = "/dev/sda";
	      type = "disk";
	      content = {
	        type = "gpt";
	        partitions = {
		  boot = {
		    size = "1M";
		    type = "EF02"; # Partition for GRUB MBR
 		 };
	          ESP = {
	            type = "EF00";  # EFI partition
	            size = "1G";  # Size 1GB
	            content = {
	              type = "filesystem";
	              format = "vfat";
	              mountpoint = "/boot";
		      extraArgs = ["-nboot"]; # Add label boot
	            };
	          };

	          swap = {
	            size = "8G";  # Swap partition 8 GB
	            content = {
	              type = "swap";
		      extraArgs = ["-Lswap"];
	            };
	          };

	          root = {
	            size = "100%";  # Rest of free space for root
	            content = {
	              type = "filesystem";
	              format = "ext4";
	              mountpoint = "/";
 	              extraArgs = ["-Lnixos"]; # Add label nixos

	            };

	          };

	        };

	      };

	    };
	  };
	};
}
