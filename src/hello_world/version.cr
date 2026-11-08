class HelloWorld
  VERSION = {{
              `shards version "#{__DIR__}"`.chomp.stringify +
              " (rev " +
              `git rev-parse --short HEAD`.chomp.stringify +
              ", build: " +
              (flag?(:release) ? "release" : "non-release").stringify +
              ")" +
              `date '+ %Y-%m-%d %H:%M:%S'`.chomp.stringify
            }}
end
