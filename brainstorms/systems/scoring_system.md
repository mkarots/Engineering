# Nested scoring system


Total score is assembled by weighting the scores of fields


##
```protobuf
message Score{
    string name = 1;
    float32 value = 2; #
    int32 weight = 3;
    repeated Score fields = 4;
}
```
##
```yaml
A:
    B:
        B1
        B2
    C:
        C1
        C2
    D:
        D1
        D2
```

##
```golang
type Scorer interface {
    Score() float32
}

type score struct {
    Name: string
    Value: float32
    Weight: int32
    fields: []*score
}

func (s *score) Score() float32 {
    var score float32

    for k, v := range s.fields {
        score := k.Score()
    }

    return score
}

```
