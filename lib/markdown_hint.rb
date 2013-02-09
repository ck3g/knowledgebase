class MarkdownHint
  def self.example
    %Q{
###### Headers
```
# This is an <h1> tag
## This is an <h2> tag
###### This is an <h6> tag
```

###### Text styles
```
*this text is italic*
_this text is italic too_
**this is bold text**
__this is bold text too__
```

###### Links
```
[Link Text](http://example.com/link-href)
```

###### Images
```
![Image alt](http://example.com/image-link.png)
```

###### Lists
```
* List item 1.
* List item 2.
  * Subitem 2.1.
  * Subitem 2.2.

1. Ordered list 1.
2. Ordered list 2.
   2.1. subitem
   2.2. subitem
```

###### Blockquotes
```
> Quoted text
> Another part of quote
```

##### Code samples
    ```ruby
    def method(name)
      puts "Hello, \#\{name\}"
    end
    ```

###### Indent your code 4 spaces
```
    def example
      puts "I'm example"
    end
```
    }
  end
end
