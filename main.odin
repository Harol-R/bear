package main

import "core:fmt"
import "core:os"
import "core:strings"
import "core:strconv"
import color "lib"
import "core:time"

//variable data type def
variable :: struct{
    name:string,
    value:f32
}

//Array in which the variables are stored
stack:[dynamic]variable

main :: proc() {
    Interpreter("main.bear")
}

Interpreter :: proc(path:string) {
    lines:= parse_line(path)

    //for i in lines
    for i:= 0; i < len(lines); i += 1{
        //words:= strings.split(i, " ")
        words:= strings.fields(lines[i])
        if len(words) == 0 {
            continue
        }

        if words[0] == "VAR"{
            if len(words) == 3{
                //only f32 vars for now
                v,err := strconv.parse_f32(words[2])
                
                var:variable
                var.name = words[1]
                var.value =  v

                if err == false{
                    fmt.print(color.red("COULDNT CREATE VARIABLE NAMED "))
                    fmt.print(var.name)
                    fmt.println(color.red(" INCORRECT VALUE"))
                    return
                }

                append(&stack,var)
                
                fmt.println(var)
            
            }else { // error handle
                fmt.print(color.red("MORE OR LESS THAN 2 ARGUMENTS on Line: "))
                fmt.println(i + 1)
                return
            }
        }

        if words[0] == "ADD"{
            if len(words) == 4{
                
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
                                a,err:= strconv.parse_f32(words[1])
                                b,err_:= strconv.parse_f32(words[2])
                                i.value = a+b
                            }
                        }
                    }
                }

                
            } else{
                fmt.print(color.red("MORE OR LESS THAN 3 ARGUMENTS on Line: "))
                fmt.println(i + 1)
                return
            }
        }

        if words[0] == "SUB"{
            if len(words) == 4{
                
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
                                        n.value = i.value - p.value
                                    }
                                }
                            }
                        }
                    }

                    if found == false{
                        //res = a + b
                        for &i in stack{
                            if i.name == e{
                                a,err:= strconv.parse_f32(words[1])
                                b,err_:= strconv.parse_f32(words[2])
                                i.value = a-b
                            }
                        }
                    }
                }

                
            } else{
                fmt.print(color.red("MORE OR LESS THAN 3 ARGUMENTS on Line: "))
                fmt.println(i + 1)
                return
            }
        }

        if words[0] == "MUL"{
            if len(words) == 4{
                
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
                                        n.value = i.value * p.value
                                    }
                                }
                            }
                        }
                    }

                    if found == false{
                        //res = a + b
                        for &i in stack{
                            if i.name == e{
                                a,err:= strconv.parse_f32(words[1])
                                b,err_:= strconv.parse_f32(words[2])
                                i.value = a*b
                            }
                        }
                    }
                }

                
            } else{
                fmt.print(color.red("MORE OR LESS THAN 3 ARGUMENTS on Line: "))
                fmt.println(i + 1)
                return
            }
        }

        if words[0] == "DIV"{
            if len(words) == 4{
                
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
                                        n.value = i.value / p.value
                                    }
                                }
                            }
                        }
                    }

                    if found == false{
                        //res = a + b
                        for &i in stack{
                            if i.name == e{
                                a,err:= strconv.parse_f32(words[1])
                                b,err_:= strconv.parse_f32(words[2])
                                i.value = a/b
                            }
                        }
                    }
                }

                
            } else{
                fmt.print(color.red("MORE OR LESS THAN 3 ARGUMENTS on Line: "))
                fmt.println(i + 1)
                return
            }
        }

        if words[0] == "PRINT"{
            found:bool
            if len(words) == 2{
                for i in stack{
                    if i.name == words[1]{
                        found = true
                        fmt.print(i.value)
                    }
                }
            }

            if found == false{
                // fmt.print(color.red("VARIABLE COULD NOT BE FOUND LINE: "))
                // fmt.println(line)
                if len(words) > 1 {
                    w,err:= strings.replace(words[1],"_", " ",-1)
                    fmt.print(w)
                } else{
                    fmt.print(color.red("VARIABLE or INPUT COULD NOT BE FOUND LINE: "))
                    fmt.println(i + 1)
                    return
                }
                
            }
        }

        if words[0] == "PRINTLN"{
            found:bool
            if len(words) == 2{
                for i in stack{
                    if i.name == words[1]{
                        found = true
                        fmt.println(i.value)
                    }
                }
            }

            if found == false{
                // fmt.print(color.red("VARIABLE COULD NOT BE FOUND LINE: "))
                // fmt.println(line)
                if len(words) > 1{
                    w,err:= strings.replace(words[1],"_", " ",-1)
                    fmt.println(w)
                } else{
                    fmt.print(color.red("VARIABLE or INPUT COULD NOT BE FOUND LINE: "))
                    fmt.println(i + 1)
                    return
                }
                
            }
        }

        if words[0] == "SET"{
            a,err:= strconv.parse_f32(words[2])
            found:bool
            if len(words) == 3{
                for &i in stack{
                    // if i.name == words[1]{
                    //     found = true
                    //     i.value = a
                    // }
                    if i.name == words[1]{
                        for p in stack{
                            if p.name == words[2]{
                                found = true
                                i.value = p.value
                            }
                        }
                    }

                }

                if found == false {
                    fmt.print(color.red("SET VALUE: VARIABLE NOT FOUND LINE: "))
                    fmt.println(i + 1)
                }
            }
        }

        if words[0] == "WAIT"{
            if len(words) == 1{
                time.sleep(time.Second)
            } else{
                fmt.print(color.red("NOT ARGUMENTS NEEDED ON LINE: "))
                fmt.println(i + 1)
            }
        }

        if words[0] == "FREE"{
            if len(words) == 2{
                for i,idx in stack{
                    if i.name == words[1]{
                        unordered_remove(&stack,idx)
                    }
                }
            } 
        }

        if words[0] == "IF"{
            if len(words) == 4{

                a:= words[1]
                operator:= words[2]
                b:= words[3]

                cond_true:bool = false
                found:bool = false
                for i in stack{
                    if i.name == a{
                        for p in stack{
                            if p.name == b{
                                found = true
                                if operator == "=="{
                                    cond_true = i.value == p.value
                                    fmt.println(color.green("IF STATEMENT IS "),cond_true)
                                }
                                if operator == ">"{
                                    cond_true = bool(i.value > p.value)
                                    fmt.println(color.green("IF STATEMENT IS "),cond_true)
                                }
                                if operator == "<"{
                                    cond_true = bool(i.value < p.value)
                                    fmt.println(color.green("IF STATEMENT IS "),cond_true)
                                }
                                if operator == "!="{
                                    cond_true = bool(i.value != p.value)
                                    fmt.println(color.green("IF STATEMENT IS "),cond_true)
                                }
                                if operator == "<="{
                                    cond_true = bool(i.value <= p.value)
                                    fmt.println(color.green("IF STATEMENT IS "),cond_true)
                                }
                                if operator == ">="{
                                    cond_true = bool(i.value >= p.value)
                                    fmt.println(color.green("IF STATEMENT IS "),cond_true)
                                }
                            }
                        }
                    }
                }

                if found == false{
                    val1,err:= strconv.parse_f32(words[1])
                    val2,err_:= strconv.parse_f32(words[3])
                    
                    
                    if operator == "=="{
                        cond_true = val1 == val2
                        fmt.println(color.green("IF STATEMENT IS "),cond_true)
                    }
                    if operator == ">"{
                        cond_true = bool(val1 > val2)
                        fmt.println(color.green("IF STATEMENT IS "),cond_true)
                    }
                    if operator == "<"{
                        cond_true = bool(val1 < val2)
                        fmt.println(color.green("IF STATEMENT IS "),cond_true)
                    }
                    if operator == "!="{
                        cond_true = bool(val1 != val2)
                        fmt.println(color.green("IF STATEMENT IS "),cond_true)
                    }
                    if operator == ">="{
                        cond_true = bool(val1 >= val2)
                        fmt.println(color.green("IF STATEMENT IS "),cond_true)
                    }
                    if operator == "<="{
                        cond_true = bool(val1 <= val2)
                        fmt.println(color.green("IF STATEMENT IS "),cond_true)
                    }
                }

                //if "IF" is not true skip line
                if cond_true ==  false{
                    i += 1
                }
            }
        }

        if words[0] == "GETKEY"{
            if len(words) >= 2{
                for &i in stack{
                    if i.name == words[1]{
                        
                        buf:[1]u8
                        n, _ := os.read(os.stdin,buf[:])
                        input:= string(buf[:n])
                        i.value = f32(buf[0])


                    }
                }
            }
        }

        if words[0] == "JMP"{
            if len(words) == 2{
                l,err:= strconv.parse_f32(words[1])
                i = int(l - 1 )
                fmt.println(color.white("MOVED TO LINE: "), l)
                continue
            }else { // error handle
                fmt.print(color.red("MORE OR LESS THAN one ARGUMENTS on Line: "))
                fmt.println(i + 1)
                return
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
