set shell = CreateObject("WScript.Shell")
set env = shell.Environment("Process")
env.Item("HOME") = "C:\msys64\home\raa0121"
env.Item("VIM") = "C:\msys64\mingw64\share\vim"
env.Item("VIMRUNTIME") = "C:\msys64\mingw64\share\vim\runtime"
env.Item("GOROOT") = "C:\Users\raa0121\sdk\go1.21.3"
env.Item("GOPATH") = "C:\msys64\home\raa0121\go"
env.Item("ANDROID_SDK_HOME") = "D:\android-sdk"
env.Item("ANDROID_HOME") = "D:\android-sdk"
env.Item("LESSCHARSET") = "utf-8"
env.Item("LC_ALLl") = "C"
env.Item("LANG") = "ja_JP.UTF-8"
env.Item("PATH") = env.Item("GOROOT") & "\bin;F:\Git\bin;C:\Users\raa0121\.deno\bin;F:\Java\jdk1.8.0_151\bin;C:\sbt\bin;C:\Users\raa0121\.cargo\bin;C:\nodejs\16.17.0;C:\msys64\home\raa0121\bin;C:\msys64\mingw64\bin;C:\msys64\usr\bin;C:\WINDOWS\system32;C:\WINDOWS;C:\WINDOWS\System32\Wbem;C:\Program Files\PowerShell\7;C:\Windows\System32\WindowsPowerShell\v1.0"
shell.Run "gvim", , FALSE
