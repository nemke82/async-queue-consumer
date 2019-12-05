# async-queue-consumer
Bash script to fire up all Magento 2 queue:consumers and kill them after 50 seconds

Simple how-to:
1) edit env.php file and add:

```
'cron_consumers_runner' => [
  'cron_run' => false,
  'max_messages' => 20000,
  'consumers' => []
],
```

2) wget -c https://raw.githubusercontent.com/nemke82/async-queue-consumer/master/async-queue-consumer-m2-3.sh

3) Configure cron task to run on every minute, example:
```
* * * * bash /path/to/your/m2docoort/async-queue-consumer-m2-3.sh
```

OR you can beautify it with timestamp and output:
```
* * * * bash /path/to/your/m2docroot/async-queue-consumer-m2-3.sh | xargs -L 1 echo date +'[%Y-%m-%d %H:%M:%S] >> /path/to/your/m2docroot/var/cron.log
```

The script idea is based on known problems with cron_consumers_runner task when Kubernetes environment used:
https://github.com/humanelement/module-advanced-message-queue-options
https://github.com/magento/magento2/commit/1d9e07b218c7c8ad1f05706828cb2dd47d2d2d58#diff-b0aaa179dca8aa117df65353dd9f5590

This script purpose is to speed up it's execution and to clear all PID processes at end and avoid PID collision
