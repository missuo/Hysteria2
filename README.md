# Hysteria2
Hysteria 2 One-Click Installation Script

## User Manual
### Resolve the domain name to your VPS IP
**If you are using Cloudflare, do not turn on the CDN service.**

### Ensure that port 80 of the VPS is not occupied
This script uses ACME to automatically apply for certificates, so please make sure that port 80 is available. You can use the following command to determine: 
```bash
lsof -i :80
```

### Execute installation command.
```bash
bash <(curl -Ls https://qwq.mx/hy2)
```

### Enter the configuration information according to the prompts.
```
Enter the port (default: 8443): 
Enter the domain: 
Enter the password (default: Hy2Best2024@):
```

## Client
### Surge
```
🇺🇸 NodeName = hysteria2, us.example.com, 8443, password=Hy2Best2024@, sni=us.example.com, download-bandwidth=600
```
### Shadowrocket
Manually fill in according to the information you entered.

## Author
**Hysteria2** © [Vincent Young](https://github.com/missuo), Released under the [MIT](./LICENSE) License.<br>