# ProcessDump
A simple demo to dump the process hierarchy information to a string, and rebuild the process layout from a specific string

In a modern operating system, each process may has a list of child processes, this demo show how to dump the hierarchy information of a specific process according to the layout information

for instance, assuming Launcher has child processes such as Xcode, Finder and Facebook. Xcode has Simulator and Debugger child processes, and
Simulator has iPhone 7 and iPad. The hierarchy information will be dumped as following

<pre><code>
Launcher<br />
├─ Xcode<br />
│  ├─ Simulator<br />
│  │  ├─ iPhone 7<br />
│  │  └─ iPad<br />
│  └─ Debugger<br />
├─ Finder<br />
└─ Facebook<br />
</code></pre>


This demo also show how to rebuild the process layout by inputing above string.


