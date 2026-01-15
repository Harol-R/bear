package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"

//variable data type def
variable :: struct{
    name:string,
    type_:string,
    value:f32
}

//Array in which the variables are stored
stack:[dynamic]variable

main :: proc() {
    lines:= parse_line("main.bear")

    res:any
    for i in lines{
        words:= strings.split(i," ")

        if words[0] == "VAR"{
            if len(words) >= 2{
                //only f32 vars for now
                v,err := strconv.parse_f32(words[2])
                var:variable
                var.name = words[1]
                var.value =  v
                append(&stack,var)
                fmt.println(var)
            }
        }

        if words[0] == "ADD"{
            if len(words) >= 2{
                a,err:= strconv.parse_f32(words[1])
                b,err_:= strconv.parse_f32(words[2])

                c:= words[1]
                d:= words[2]
                e:= words[3]
                found:bool
                
                for i in stack{
                    if i.name == c {
                        for p in stack {
                            if p.name == d{
                                //fmt.println(i.value + p.value)
                                //res = i.value + p.value
                                for &n in stack{
                                    if n.name == e{
                                        found = true
                                        n.value = i.value + p.value
                                    }
                                }
                            }
                        }
                    }

                    if found == false{
                        //res = a + b
                        for &i in stack{
                            if i.name == e{
                                i.value = a+b
                            }
                        }
                    }
                }

                
            }
        }

        if words[0] == "PRINT"{
            if len(words) >= 1{
                for i in stack{
                    if i.name == words[1]{
                        fmt.print(i.value)
                    }
                }
            }
        }

        if words[0] == "PRINTLN"{
            if len(words) >= 1{
                for i in stack{
                    if i.name == words[1]{
                        fmt.println(i.value)
                    }
                }
            }
        }

        if words[0] == "SET"{
            a,err:= strconv.parse_f32(words[2])
            if len(words) >= 2{
                for &i in stack{
                    if i.name == words[1]{
                        i.value = a
                    }
                }
            }
        }

        


    }
    delete(stack)
    //fmt.println(stack[2].value)
}

//separate each line of the file
parse_line :: proc(file_path:string) -> []string{
    file, err := os.read_entire_file_from_filename(file_path)
    if err ==  false{
        fmt.printfln("ERROR PARSING FILE: FILE CANNOT BE FOUND")
        return nil
    }
    text:= string(file)
    return strings.split(text, "\n")
}