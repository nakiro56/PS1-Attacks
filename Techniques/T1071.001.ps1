Invoke-WebRequest google.com -UserAgent "HttpBrowser/1.0" | out-null
Invoke-WebRequest google.com -UserAgent "Wget/1.9+cvs-stable (Red Hat modified)" | out-null
Invoke-WebRequest google.com -UserAgent "Opera/8.81 (Windows NT 6.0; U; en)" | out-null
Invoke-WebRequest google.com -UserAgent "*<|>*" | out-null