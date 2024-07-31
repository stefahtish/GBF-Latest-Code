xmlport 50101 Employee
{
    DefaultFieldsValidation = true;
    Direction = Import;
    Format = VariableText;
    FormatEvaluate = Legacy;

    schema
    {
    textelement(Root)
    {
    tableelement(Employee;
    Employee)
    {
    AutoReplace = false;
    AutoUpdate = false;
    MinOccurs = Zero;
    XmlName = 'Employee';

    fieldelement(No;
    Employee."No.")
    {
    }
    fieldelement(KRA;
    Employee."PIN Number")
    {
    }
    trigger OnBeforeInsertRecord()
    begin
    /*
                    EmpRec.RESET;
                    EmpRec.SETRANGE("No.",Employee."No.");
                    IF EmpRec.FIND('-') THEN
                      BEGIN
                        REPEAT
                          IF EmpRec.GET(Employee."No.") THEN
                            BEGIN
                              EmpRec.MODIFY;
                            END ELSE
                            EmpRec.INSERT;
                        UNTIL EmpRec.NEXT=0;
                      END;
                    currXMLport.SKIP;
                    */
    /*
                    EmpRec.RESET;
                    EmpRec.SETRANGE("No.",Employee."No.");
                    IF EmpRec.FIND('-') THEN
                      BEGIN
                        REPEAT
                          IF Employee.GET(EmpRec."No.") THEN
                            BEGIN
                              Employee.TRANSFERFIELDS(EmpRec);
                              Employee.MODIFY;
                            END ELSE
                              Employee.COPY(EmpRec);
                              Employee.INSERT;
                        UNTIL Employee.NEXT=0;
                      END;
                    currXMLport.SKIP;
                    */
    end;
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    trigger OnPostXmlPort()
    begin
    /*
        BEGIN
          EmpRec.SETRANGE("No.",Employee."No.");
            IF EmpRec.FIND('-') THEN
            REPEAT
              IF Employee.GET(EmpRec."No.") THEN
                BEGIN
                  Employee.TRANSFERFIELDS(EmpRec);
                  Employee.MODIFY;
                END ELSE
                  BEGIN
                    Employee.COPY(EmpRec);
                    EmpRec.MODIFY;
                  END;
            UNTIL EmpRec.NEXT=0;
        END;
        */
    end;
    var EmpRec: Record Employee;
}
