                stack = [S] // S是开始符号
                while (stack != [])
                if (stack[top] is a terminal t)
                if (t==tokens[i++])
                pop();
                else backtrack();
                else if (stack[top] is a nonterminal T)
                pop(); push(the next right hand side of T)
