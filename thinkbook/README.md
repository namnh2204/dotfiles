## fix cannot using `fn+<F5>` and `fn+<F6>` to adjust brightness:
- Add `GRUB_CMDLINE_LINUX_DEFAULT=acpi_backlight=video` in `/etc/default/grub`
- Run `sudo grub-mkconfig -o /boot/grub/grub.cfg`
