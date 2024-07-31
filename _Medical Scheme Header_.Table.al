table 50255 "Medical Scheme Header"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Selection Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Cover Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "In House", Outsourced;
        }
        field(4; "Service Provider"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF("Cover Type"=CONST(Outsourced))Vendor;
        }
        field(5; "Name of Broker"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Policy No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Policy Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Policy Expiry Date":=CalcDate('1Y', "Policy Start Date") - 1;
            end;
        }
        field(8; "Policy Expiry Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if EmpRec.Get("Employee No")then begin
                    "Employee Name":=EmpRec."First Name" + ' ' + EmpRec."Middle Name" + ' ' + EmpRec."Last Name";
                    "Blood Type":=EmpRec."Blood Type";
                    if SalaryScales.Get(EmpRec."Salary Scale")then "Entitlement -Inpatient":=SalaryScales."In Patient Limit";
                    "Entitlement -OutPatient":=SalaryScales."Out Patient Limit";
                    Dependants.Init;
                    Dependants.SetRange("Employee No.", "Employee No");
                    if Dependants.Find('-')then begin
                        repeat MedLines."Employee Code":="Employee No";
                            MedLines."Medical Scheme No":="No.";
                            MedLines."Line No.":=MedLines."Line No." + 10000;
                            MedLines.Relationship:=Dependants."Relative Code";
                            MedLines.SurName:=Dependants."Last Name";
                            MedLines."Other Names":=Dependants."First Name";
                            MedLines."Date Of Birth":=Dependants."Birth Date";
                            MedLines.Gender:=Dependants.Gender;
                            MedLines.Insert;
                        until Dependants.Next = 0;
                    end;
                end;
            /*
                MedLines.INIT;
                MedLines."Medical Scheme No":="No.";
                MedLines."Line No.":=MedLines."Line No."+10000;
                MedLines."Employee Code":="Employee No";
                MedLines.Relationship:='EMPLOYEE';
                
                IF EmpRec.GET("Employee No") THEN
                MedLines."Date Of Birth":=EmpRec."Date of Birth";
                MedLines.SurName:=EmpRec."Last Name";
                MedLines."Other Names":=EmpRec."First Name";
                MedLines."Service Provider":="Service Provider";
                //HANDLE THE ERROR INCURED FROM EXISITIN RECORDS BY ISAAC
                IF MedLines.INSERT THEN  BEGIN
                ;
                END ELSE
                MedLines.MODIFY;
                 //END
                IF NOT MedLines.GET(MedLines."Medical Scheme No",MedLines."Line No.") THEN
                BEGIN
                
                Dependants.RESET;
                Dependants.SETRANGE(Dependants."Employee Code","Employee No");
                IF Dependants.FIND('-') THEN
                REPEAT
                  MedLines.INIT;
                  MedLines."Medical Scheme No":="No.";
                  MedLines."Line No.":=MedLines."Line No."+10000;
                  MedLines."Employee Code":="Employee No";
                  //MedLines.Relationship:=Dependants.Relationship;
                  //MedLines.SurName:=Dependants.SurName;
                  //MedLines."Other Names":=Dependants."Other Names";
                
                  IF EmpRec.GET("Employee No") THEN
                 // MedLines."Date Of Birth":=EmpRec."Date Of Birth";
                
                  MedLines."Date Of Birth":=Dependants."Date of Birth";
                  MedLines."Service Provider":="Service Provider";
                
                  IF NOT MedLines.GET(MedLines."Medical Scheme No",MedLines."Line No.") THEN
                //HANDLE THE ERROR INCURED FROM EXISITIN RECORDS BY ISAAC
                
                IF MedLines.INSERT THEN  BEGIN
                ;
                END ELSE
                MedLines.MODIFY;
                //END
                UNTIL Dependants.NEXT=0;
                END;
                */
            end;
        }
        field(10; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Entitlement -Inpatient"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Entitlement -OutPatient"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Fiscal Year"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Budget Name";
        }
        field(14; "No. Of Lives"; Integer)
        {
            CalcFormula = Count("Medical Scheme Lines" WHERE("Medical Scheme No"=FIELD("No.")));
            FieldClass = FlowField;
        }
        field(15; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Cover Selected"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                Validate("Employee No");
            end;
        }
        field(17; "In-Patient Claims"; Decimal)
        {
            CalcFormula = Sum("Claim Line"."Approved Amount" WHERE("Employee No"=FIELD("Employee No"), "Claim Type"=CONST("In Patient")));
            FieldClass = FlowField;
        }
        field(18; "Out-Patient Claims"; Decimal)
        {
            CalcFormula = Sum("Claim Line"."Approved Amount" WHERE("Employee No"=FIELD("Employee No"), "Claim Type"=CONST("Out Patient"), "Policy Start Date"=FIELD("Policy Start Date")));
            FieldClass = FlowField;
        }
        field(19; "User ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Blood Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "No.", "Employee No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Cover Selection Nos");
            NoSeriesMgt.InitSeries(HRSetup."Cover Selection Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;
    var MedLines: Record "Medical Scheme Lines";
    Dependants: Record "Employee Relative";
    EmpRec: Record Employee;
    UserRec: Record "User Setup";
    HumanResSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    SalaryScales: Record "Salary Scale";
    MedScheme: Record "Medical Scheme Header";
    AcctPeriod: Record "Accounting Period";
    HRSetup: Record "Human Resources Setup";
}
