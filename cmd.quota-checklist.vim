1. activate user root and changing to root console: 
    - sudo passwd root", "sudo usermod -U root", "su - root
2. adding to fstab & remount device: 
    - usrquota,grpquota
    - mount /dev/sda /home -o remount  
3. restarting deamon:
    - service quota restart
4. creating user & group files:
    - touch aquota.user aquota.group
    - chmod 600 aquota*
5. scanning quotas:
    - scanning quotas: "quotacheck -avug"
6. activate & checking quotas:
    - quotaon -av (-avug) (-F vfsv0)
    - checking Blocks with "dumpe2fs -h /dev/sd* | grep "Block size""
7. seting limits:
    - changing limits: edquota -f /home -u username 
8. checking quota status as user: 
    - quota
    - printing status: repquota -avug /home
