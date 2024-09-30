{

  disko.devices = {
	disk = {
	    my-disk = {

	      device = "/dev/sda";

	      type = "disk";

	      content = {

	        type = "gpt";

	        partitions = {

	          efi = {

	            type = "EF00";  # EFI partycja

	            size = "500M";  # Rozmiar 500MB

	            content = {

	              type = "filesystem";

	              format = "vfat";

	              mountpoint = "/boot";
		      
		      extraArgs= "-n boot"; # Add label boot

	            };

	          };

	          swap = {

	            size = "8G";  # Partycja swap 8 GB

	            content = {

	              type = "swap";

	            };

	          };

	          root = {

	            size = "100%";  # Reszta wolnego miejsca na root

	            content = {

	              type = "filesystem";

	              format = "ext4";

	              mountpoint = "/";
 	              extraArgs = "-L nixos"; # Add label nixos

	            };

	          };

	        };

	      };

	    };
	  };
	};
}
