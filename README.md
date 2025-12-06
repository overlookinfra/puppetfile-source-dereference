# Puppetfile Source Dereference

This is a simple tool to replace forge references with the git source in a Puppetfile.
The intent is to reduce your dependency on the Puppet Forge in cases of service interruptions.

The simplest use case is to simply run the tool in the root directory of a Puppet module.
It will generate a `Puppetfile.out`, which you will need to inspect and clean up.

Comments and formatting will not be preserved, you'll need to reconcile that.

> ⚠️ There is not a standard mapping of Forge release versions to git ref (branch, tag, etc).
> This tool will take a very simplistic guess at the ref, but many modules will be wrong.
> You'll need to use your human brain and look at the module repo and decide which ref to use.

