set history filename ~/.gdb_history
set history save

define hook-quit
    set confirm off
end

add-auto-load-safe-path /home/piotr/Desktop/rustboot/arch/arm/.gdbinit
add-auto-load-safe-path /home/piotr/Desktop/rustboot/arch/x86_64/.gdbinit
add-auto-load-safe-path /home/piotr/Desktop/rustboot/arch/i686/.gdbinit
add-auto-load-safe-path /home/piotr/Desktop/rustboot/arch/x86/.gdbinit
add-auto-load-safe-path /usr/lib/libstdc++.so.6.0.19-gdb.py
