--SUB PROGRAMS(FUNCTIONS,PROCEDURES)

/*1)Write a user-defined function to return a count of the total records inserted in the ‘passenger’ table.
Query >>*/ Create or replace function totalpassenger return number
                   as 
                   tot int; 
                   begin
                   select count(*) into tot from passenger;
                   return tot;
                   end;
                   /         
/*2)Write a stored procedure in PLSQL to delete a record from a ‘passenger’ table.
Query >>*/  Create or replace procedure deletepass (delid char)
                   is
                   begin
                   delete passenger where passengerid = to_number(delid); 
                   end;
                   /
/*3)Write a User-defined function that retrieves the total number of records from the “travel_class” table where the “TravelClassID” matches ‘economy’.
Query >>*/ Create or replace function totalpassenger
                  return number
                  as
                  temp int;
                  begin
                  select count(*) into tmp
                  from travel_class t, reservation r
                  where r.travelclassid = t.travelclassid and
                travelclass= ‘economy’;
                return tmp;
                end;
                /
/*4)Write a stored procedure in PLSQL to insert a new record to the ‘passenger’ table.
Query >> */Create or replace procedure insertPASSENGER(pid in number,  
                f_n in varchar, m_n in varchar, l_n in varchar, gender in char, ph
                in number, email in varchar, p_type in varchar)
                as
                begin
                insert 
                into passenger values(pid,f_n,m_n,l_n,gender,ph,email,p_type);
                end;
                / 
/*5)Write a stored procedure in PLSQL to update the ‘reservation’ table.
Query >>*/ Create or replace procedure updatecustomer(id int, f_num 
                 varchar)
                 as
                 begin
                 update reservation set flightnumber = f_num
                 where passengerid=id;
                 end;
                 /
--TRIGGERS     
                   
/*1)Write a query to insert the name into the pass_info table before inserting the records in the ‘passenger’ table using triggers and display the inserted name.
Query>>*/ Create or replace trigger PASSENGERNAME
                Before insert on passenger for each row
                Begin
                   Insert into pass_info(name) values (:NEW.first);
                End;
                 /
/*2)Write a query to insert the name of the female passenger into the ‘pass_info’ table before inserting the records in the passenger table using triggers and display the inserted names.
Query>>*/Create or replace trigger FEMALEPASSENGERLIST
               Before insert on passenger for each row
               Begin
                 If :NEW.gender=’F’ then
                     Insert into pass_info(name) values(:NEW.first);
                 End if;
                End;
                /
/*3)Write a query to insert the first 3 passengers first names into the pass_info table before inserting the records in the ‘passenger’ table using trigger.
Query>>*/ Create or replace trigger FIRSTNAME
               Before insert on passenger for each row
               Declare
                  V number;
               Begin
                   Select count(*) into V from pass_info;
                   If V<3 then insert into pass_info(name) values(:NEW.first);
                   End if;
               End;
               /
/*4) Write a query to insert the first 3 passengers’ first names converted to uppercase into the pass_info table before inserting the records in the ‘passenger’ table using trigger.
Query>>*/ Create or replace trigger FIRSTNAME
               Before insert on passenger for each row
               Declare
                  V number;
               Begin
                  Select count(*) into V from pass_info;
                   If V<3 then insert into pass_info(name) values(upper(:NEW.first));
                   End if;
               End
               /
/*5)Write a query to insert the updated first names and convert them to uppercase into the pass_info table using triggers and display names.
Query>>*/ Create or replace trigger PASSENGERNAME
               Before update on passenger for each row
               Begin
                  Insert into pass_info(name) values(:NEW.first);
               End;
               /
--CURSORS
                 
/*1) Write a cursor in PLSQL to display all the Passengers list in ascending order.
Query >> */declare
                cursor passengerlist is
                select first from passenger
                order by first;
            begin
                for i in passengerlist loop
                dbms_output. put_line (i. first);
                end loop;
            end;
            /
/*2) Write a cursor in PLSQL to display all the Passengers list and reservationdate, Seatnumber, cost information in ascending order.
Query >>*/ declare
            		cursor passengerlist is
            		select p.first, r.reservationdate, r.seatnumber, r.cost
            		from reservation r, passenger p
            		where r.passengerid = p.passengerid
            		order by first;
            begin
            		for i in passengerlist loop
                      dbms_output. put_line(i. first ||' '||i.reservationdate ||' '|| i.seatnumber||i.cost);
            	  end loop;
            end;
            /
              
/*3) Write a cursor in PLSQL to display all the Passengers list and travelclass.
Query >>*/ declare
            		cursor passengerlist is
                     select p.first, t.travelclass from passenger p,travel_class t,  
                     reservation r where p.passengerid = r.passengerid 
                     and r.travelclassid = t.travelclassid;
           begin
            		for i in passengerlist loop
            		      dbms_output. put_line(i. first ||' '|i.travelclass);
            		end loop;
            end;
            /
/*4) Write a cursor in PLSQL to display all the Passengers list and count how many first names are fetched as well.
Query >>*/ declare
            		cursor passengerlist is
            		select first from passenger;
            		fetch_count number: = 0;
           begin
    	          select count (*) into fetch_count from passenger;
    	          for i in passengerlist loop
    	                dbms_output. Put_line('Passenger name||i.first) ;
    	          end loop;
    	          dbms_output. put_line('Total rows fetched is ||' '|| fetch_count);
            end;
            /

/*5) Write a cursor in PLSQL that retrieves and display the names of passengers who have booked a ‘first’ class ticket from a passenger table.
Query >>*/ declare
            		cursor passengerlist is
            		select p.first from passenger p, reservation r, travel_class t
                 where p.passengerid = r.travelclassid and t.travelclassid = r.travelclassid and t.travelclass = 'first';
           begin
		            for i in passengerlist loop
		                dbms_output. put_line (i. first);
		            end loop;
           end;
           /


