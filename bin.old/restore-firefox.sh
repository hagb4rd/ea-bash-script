#!/bin/bash
#sudo rm -rf /home/earendel/.cache/mozilla
#sudo rm -rf /home/earendel/.mozilla
#sudo cp -r -a /tmp/shared0/backup0/.cache/mozilla /home/earendel/.cache
#sudo  cp -r -a /tmp/shared0/backup0/.mozilla /home/earendel
#sudo cp /tmp/shared0/Documents/bookmarks* /home/earendel/Desktop
sudo chown -hR earendel:earendel /home/earendel/Desktop
sudo chown -hR earendel:earendel /home/earendel/.cache/mozilla
sudo chown -hR earendel:earendel /home/earendel/.mozilla

