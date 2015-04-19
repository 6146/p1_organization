%{
    #define _GNU_SOURCE
    #include "unistd.h"
    #include "global.h"

    void yyerror ();
      
    int commandDone;
%}

%token STRING

%%
line            :   /* empty */
                    |command                        {   execute();  commandDone = 1;   }
;

command         :   fgCommand
                    |fgCommand '&'
;

fgCommand       :   simpleCmd
;

simpleCmd       :   progInvocation inputRedirect outputRedirect
;

progInvocation  :   STRING args
;

inputRedirect   :   /* empty */
                    |'<' STRING
;

outputRedirect  :   /* empty */          
                    |'>' STRING
;

args            :   /* empty */
                    |args STRING
;

%%

/****************************************************************
                  词法分析函数
****************************************************************/


/****************************************************************
                  错误信息执行函数
****************************************************************/
void yyerror()
{
    printf("你输入的命令不正确，请重新输入！\n");
}

/****************************************************************
                  main主函数
****************************************************************/
int main(int argc, char** argv) {
    int i;
    char c;

    init(); //初始化环境
    commandDone = 0;
    
    printf("6146 @computer:%s$--> ", get_current_dir_name()); //打印提示符信息

    while(1){

      c=getchar();
      if(c!=EOF)
          ungetc(c,stdin);
        
        yyparse(); //调用语法分析函数，该函数由yylex()提供当前输入的单词符号

        if(commandDone == 1){ //命令已经执行完成后，添加历史记录信息
            commandDone = 0;
            addHistory(inputBuff);
        }
        inputBuff[0] = '\0'; 
        printf("6146 @computer:%s$--> ", get_current_dir_name()); //打印提示符信息
     }

    return (EXIT_SUCCESS);
}
