% Simple check website security

:- consult('getyesno.pl').

%
% Main control procedures
%

start :-
   write('This program check your website is secure enough or not.'),nl,
   write('Answer all questions with Y for yes or N for no.'),nl,
   write('At the end of program, some advise will be given to you.'),nl,
   clear_stored_answers,
   try_all_possibilities.

try_all_possibilities :-     % Backtrack through all possibilities...
   may_be_possible(D),
   explain(D),
   fail.

try_all_possibilities.       % ...then succeed with no further action.


%
% Diagnostic knowledge base
%   (conditions under which to give each diagnosis)
%

may_be_possible(sql_injection_attack) :-
   user_says(website_use_database,yes),
   user_says(website_use_paramterisequery,no),
   user_says(website_is_static,no).

may_be_possible(command_injection_attack) :-
   user_says(website_use_os_command,yes),
   user_says(website_has_inputfield,yes).
   
may_be_possible(code_injection_attack) :-
   user_says(website_has_uploadfield,yes).

may_be_possible(xss_attack) :-
   user_says(website_has_inputfield,yes),
   user_says(website_use_javascript,yes).

may_be_possible(csrf_attack) :-
   may_be_possible(xss_attack),
   user_says(website_has_login,yes),
   user_says(website_has_form,yes).

may_be_possible(broken_uthentication_attack) :-
   user_says(website_use_database,yes),
   user_says(website_has_login,yes).
   
may_be_possible(known_vulnerabilities_attack) :-
   user_says(website_use_cms,yes).
   
may_be_possible(security_misconfiguration_attack) :-
   user_says(website_use_own_server,yes).


%
% Case knowledge base
%   (information supplied by the user during the consultation)
%

:- dynamic(stored_answer/2).

   % (Clauses get added as user answers questions.)


%
% Procedure to get rid of the stored answers
% without abolishing the dynamic declaration
%

clear_stored_answers :- retract(stored_answer(_,_)),fail.
clear_stored_answers.



user_says(Q,A) :- stored_answer(Q,A).

user_says(Q,A) :- \+ stored_answer(Q,_),
                  nl,nl,
                  ask_question(Q),
                  get_yes_or_no(Response),
                  asserta(stored_answer(Q,Response)),
                  Response = A.



ask_question(website_use_database) :-
   write('Does your website use database?'),nl.
   
ask_question(website_use_paramterisequery) :-
   write('Does your website use parametrise SQL query?'),nl.
   
ask_question(website_use_os_command) :-
   write('Does your website use any OS command?'),nl.

ask_question(website_is_static) :-
   write('Is your website static? '),nl.

ask_question(website_has_login) :-
   write('Has your website login page?'),nl.

ask_question(website_has_form) :-
   write('Is there any HTTP form in your website?'),nl.

ask_question(website_has_inputfield) :-
   write('Is there any input field in your website?'),nl.

ask_question(website_has_uploadfield) :-
   write('Is there any upload file field in your website?'),nl.

ask_question(website_use_cms) :-
   write('Do you use popular CMS for your website?'),nl.

ask_question(website_use_javascript) :-
   write('Does your website use JavaScript?'),nl.
   
ask_question(website_use_own_server) :-
   write('Does you use your own server for website?'),nl.


explain(command_injection_attack) :-
   nl,
   write('Command injection attacks are possible when an application passes unsafe user supplied data (forms, cookies, HTTP headers etc.) to a system shell. '),nl,
   write('1- Validate use input. 2- Use safe API. 3- Contextually escape user data.'),nl.

explain(xss_attack) :-
   nl,
   write('XSS flaws occur whenever an application includes untrusted data in a new web page without proper validation or escaping,'),nl,
   write(' or updates an existing web page with user supplied data using a browser API that can create JavaScript.'),nl,
   write('1- Never insert untrusted data except in allowed locations. 2- Always do HTML escape input parameters. '),nl.

explain(sql_injection_attack) :-
   nl,
   write('Injection flaws occur when an application sends untrusted data to an interpreter.'),nl,
   write('They are often found in SQL, LDAP, XPath, or NoSQL queries; OS commands; XML parsers, SMTP Headers, expression languages, etc.'),nl.

explain(csrf_attack) :-
   nl,
   write('A CSRF attack forces a logged-on victim’s browser to send a forged HTTP request,'),nl,
   write('including the victim’s session cookie and any other automatically included authentication information, to a vulnerable web application.'),nl,
   write('Such an attack allows the attacker to force a victim’s browser to generate requests the vulnerable application thinks are legitimate requests from the victim.'),nl.

explain(broken_uthentication_attack) :-
   nl,
   write('Application functions related to authentication and session management are often implemented incorrectly,'),nl,
   write(' allowing attackers to compromise passwords, keys, or session tokens,'),nl,
   write(' or to exploit other implementation flaws to assume other users’ identities (temporarily or permanently).'),nl.

explain(known_vulnerabilities_attack) :-
   nl,
   write('Components, such as libraries, frameworks, and other software modules, run with the same privileges as the application.'),nl,
   write(' If a vulnerable component is exploited, such an attack can facilitate serious data loss or server takeover.'),nl.

explain(security_misconfiguration_attack) :-
   nl,
   write('Good security requires having a secure configuration defined and deployed for the application, frameworks, application server, web server, database server, platform, etc.'),nl,
   write('Secure settings should be defined, implemented, and maintained, as defaults are often insecure. Additionally, software should be kept up to date.'),nl.

