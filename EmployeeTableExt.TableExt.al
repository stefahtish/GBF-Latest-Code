tableextension 50101 EmployeeTableExt extends Employee
{
    fields
    {
        modify("Birth Date")
        {
            trigger OnAfterValidate()
            begin
                HumanResSetup.Get();
                if "Special Retirement Age" then begin
                    Evaluate(dateform, Format(HumanResSetup."Other Retirement Age") + 'Y');
                    "Retirement Date" := CalcDate(dateform, "Birth Date");
                    "Date of Birth - Age" := HRDates.DetermineAge("Birth Date", Today);
                end
                else begin
                    Evaluate(dateform, Format(HumanResSetup."Retirement Age") + 'Y');
                    "Retirement Date" := CalcDate(dateform, "Birth Date");
                    "Date of Birth - Age" := HRDates.DetermineAge("Birth Date", Today);
                end;
                ;
            end;
        }
        modify("Employment Date")
        {
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                "Date Of Join" := "Employment Date";
            end;
        }
        field(60058; "Date of Birth - Age"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60059; Password; Code[20])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(60060; "Nature of Employment"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract".Code;

            trigger OnValidate()
            begin
                if EmpContract.Get("Nature of Employment") then "Employment Type" := EmpContract."Employee Type"
            end;
        }
        field(60061; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ContractPeriod := CalcDate("Contract Length", "Contract Start Date");
                "Contract End Date" := ContractPeriod;
            end;
        }
        field(60062; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60063; "Employment Date - Age"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60064; "First Language"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60065; "Second Language"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60066; "First Language Read"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60067; "First Language Write"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60068; "First Language Speak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60069; "Second Language Read"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60070; "Second Language Write"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60071; "Second Language Speak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60072; "Other Language"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60073; "Job Position"; Code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                if Jobs.Get("Job Position") then begin
                    "Job Title2" := Jobs."Job Description";
                end;
            end;
        }
        field(60074; "Job Position Title"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(60075; "Annual Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60076; "Compassionate Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60077; "Maternity Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60078; "Paternity Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60079; "Sick Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60080; "Study Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60081; "Other Leave Days (Total)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60082; "Leave Period Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Periods"."Leave Period";
        }
        field(60083; "Leave Type Filter"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60084; "Reimbursed Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60085; "Cash - Leave Earned"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60086; "Cash Per Leave Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60087; Signature; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(60088; "Lecturer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full-Time,Part-Time';
            OptionMembers = " ","Full-Time","Part-Time";
        }
        field(60089; "Lecturer Password"; Code[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(60090; "Is Lecturer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60091; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(60092; Disabled; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ",No,Yes;
        }
        field(60093; "NSSF No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50000; "Pays NSSF?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50001; "Pays tax?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Basic Pay"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = CONST(Payment), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Basic Salary Code" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50003; "Employee Nature"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; "Position TO Succeed"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Total Allowances"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = CONST(Payment), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Non-Cash Benefit" = CONST(false), Gratuity = CONST(false), "Normal Earnings" = CONST(true), "Insurance Code" = FILTER(false)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Taxable = CONST(true), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = FILTER(Deduction | Loan), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Employee's Bank"; Code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                if Banks.Get("Employee's Bank") then "Employee Bank Name" := Banks.Name;
            end;
        }
        field(50009; "Bank Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code" = FIELD("Employee's Bank"));

            trigger OnValidate()
            begin
                if Branches.Get("Employee's Bank", "Bank Branch") then "Employee Branch Name" := Branches."Branch Name";
                "Employee Bank Sort Code" := "Employee's Bank" + "Bank Branch";
            end;
        }
        field(50010; "Bank Account Number"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Posting Group"; Code[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Employee Posting GroupX";

            trigger OnValidate()
            begin
                /*
                    IF xRec."Posting Group"='PROBATION' THEN
                    BEGIN

                     IF "Date Of Join"<>0D THEN
                     BEGIN
                       NoofMonthsWorked:=0;
                       Nextmonth:="Date Of Join";
                       REPEAT
                          Nextmonth:=CALCDATE('1M',Nextmonth);
                          NoofMonthsWorked:=NoofMonthsWorked+1;
                       UNTIL NoofMonthsWorked=HumanResSetup."Probation Period(Months)";
                          EndDate:=Nextmonth;
                     END;
                     IF EndDate>TODAY THEN
                       ERROR('You cannot change status from Probation before the probation period has expired');
                    END;
                    */
            end;
        }
        field(50012; "Salary Scale"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Scale".Scale;

            trigger OnValidate()
            begin
                if Scale.Get("Salary Scale") then Halt := Scale."Maximum Pointer";
            end;
        }
        field(50013; "Tax Deductible Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Tax Deductible" = CONST(true), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Non-Cash Benefit" = CONST(false)));
            FieldClass = FlowField;
        }
        field(50014; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = IF ("Employment Type" = FILTER(Permanent | Partime)) "Payroll PeriodX"
            ELSE IF ("Employment Type" = FILTER(Casual)) "Payroll Period Casuals"
            ELSE IF ("Employment Type" = FILTER(Trustee)) "Payroll Period Trustees";
        }
        field(50015; "SSF Employer to Date"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Employer Amount" WHERE("Tax Deductible" = CONST(true), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter")));
            FieldClass = FlowField;
        }
        field(50016; "PIN Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), Paye = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "NHIF No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Non-Cash Benefit" = CONST(true), Type = CONST(Payment), Taxable = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50020; "Pay Mode"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employee Pay Modes";
        }
        field(50021; "Home Savings"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), Type = CONST(Deduction), "Tax Deductible" = CONST(true), Retirement = CONST(false)));
            FieldClass = FlowField;
        }
        field(50022; "Retirement Contribution"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Tax Deductible" = CONST(true), Retirement = CONST(true)));
            FieldClass = FlowField;
        }
        field(50023; "Owner Occupier"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), Type = CONST(Payment), "Tax Deductible" = CONST(true)));
            FieldClass = FlowField;
        }
        field(50024; "Total Savings"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), Type = CONST("Saving Scheme"), "Payroll Period" = FIELD("Pay Period Filter")));
            FieldClass = FlowField;
        }
        field(50025; PensionNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Share Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), Shares = CONST(true)));
            Caption = 'coop skg fund';
            FieldClass = FlowField;
        }
        field(50027; "Other deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), Paye = CONST(false)));
            FieldClass = FlowField;
        }
        field(50028; Interest; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Interest Amount" WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), Type = FILTER(Deduction)));
            FieldClass = FlowField;
        }
        field(50029; "Taxable Income"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), Taxable = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50030; "ID No."; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50031; Position; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                if Jobs.Get(Position) then "Job Title2" := Jobs."Job Description";
                if ((xRec.Position <> '') and (Position <> xRec.Position)) then begin
                    Jobs.Reset;
                    Jobs.SetRange(Jobs."Job ID", Position);
                    if Jobs.Find('-') then begin
                        "Job Title2" := Jobs."Job Description";
                        /*Payroll.COPY(Rec);
                            Payroll.RESET;
                            Payroll.SETRANGE(Payroll."No.","No.");
                            IF Payroll.FIND('-') THEN BEGIN
                                Payroll."Salary Scheme Category":=Jobs.Category;
                                Payroll."Salary Steps":=Jobs.Grade;
                              //  Payroll.VALIDATE(Payroll."Salary Steps");
                                Payroll.MODIFY;
                            END;*/
                        //"Salary Scheme Category":=Jobs.Category;
                        //"Salary Steps":=Jobs.Grade;
                        //MODIFY;
                    end;
                end;
            end;
        }
        field(50032; "Full / Part Time"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Full Time, Part Time';
            OptionMembers = "Full Time"," Part Time";
        }
        field(50033; "Contract Type"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract".Code;

            trigger OnValidate()
            begin
                /*
                    IF "Contract Type"="Contract Type"::"Long-Term" THEN
                      "Contract Length"> '6M' ELSE
                      ERROR('The Period is too short for the Contract Type');

                    IF "Contract Type"="Contract Type"::"Short-Term" THEN
                      "Contract Length"<'7M' ELSE
                      ERROR('The Period is Longer than the Contract Type');
                    */
            end;
        }
        field(50034; "Type of Contract"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract";

            trigger OnValidate()
            begin
                if EmpContract.Get("Type of Contract") then "Contract Length" := EmpContract.Tenure;
            end;
        }
        field(50035; "Notice Period"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ",Single,Married,Separated,Divorced,"Widow(er)",Other;
        }
        field(50037; "Ethnic Origin"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ',Black,African American,Hispanic,Asian,Indian,White';
            OptionMembers = " ",Black,"African American",Hispanic,Asian,Indian,white;
        }
        field(50038; "First Language (R/W/S)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(50039; "Driving Licence"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50040; "KRA PIN No."; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "Date Of Join"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                HumanResSetup.Get;
                HumanResSetup.TestField("Probation Period");
                "Employment Date" := "Date Of Join";
                "End Of Probation Date" := CalcDate(HumanResSetup."Probation Period", "Date Of Join");
                /*
                    DateInt:=DATE2DMY("Date Of Join",1);
                    "Pro-Rata on Joining":=HumanResSetup."No. Of Days in Month"-DateInt+1;
                    PayPeriod.RESET;
                    PayPeriod.SETRANGE(PayPeriod."Starting Date",0D,"Date Of Join");
                    PayPeriod.SETRANGE(PayPeriod."New Fiscal Year",TRUE);
                    IF PayPeriod.FIND('+') THEN
                    BEGIN
                    FiscalStart:=PayPeriod."Starting Date";
                    MaturityDate:=CALCDATE('1Y',PayPeriod."Starting Date")-1;
                     MESSAGE('Maturity %1',MaturityDate)
                    END;

                    IF ("Posting Group"='PERMANENT') OR ("Posting Group"='DG') THEN BEGIN
                    //MESSAGE('Date of join %1',"Date Of Join") ;
                     Entitlement:=ROUND(((MaturityDate-"Date Of Join")/30),1)*2.5;

                    EmpLeaves.RESET;
                    EmpLeaves.SETRANGE(EmpLeaves."Employee No","No.");
                    EmpLeaves.SETRANGE(EmpLeaves."Maturity Date",MaturityDate);
                    IF NOT EmpLeaves.FIND('-') THEN BEGIN
                      EmpLeaves."Employee No":="No.";
                      EmpLeaves."Leave Code":='ANNUAL';
                      EmpLeaves."Maturity Date":=MaturityDate;
                      EmpLeaves.Entitlement:=Entitlement;
                    //IF NOT EmpLeaves.GET("No.",'ANNUAL',MaturityDate) THEN
                      EmpLeaves.INSERT;
                    END;

                    END;
                      */
            end;
        }
        field(50042; "End Of Probation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50045; "Pension Scheme Join"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*  IF ("Date Of Leaving" <> 0D) AND ("Pension Scheme Join" <> 0D) THEN
                       "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");

                */
            end;
        }
        field(50046; "Medical Scheme Join"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*  IF  ("Date Of Leaving" <> 0D) AND ("Medical Scheme Join" <> 0D) THEN
                       "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");
                    */
            end;
        }
        field(50047; "Date Of Leaving"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /* IF ("Date Of Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                      "Length Of Service":= Dates.DetermineAge("Date Of Join","Date Of Leaving");
                     IF ("Pension Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                      "Time Pension Scheme":= Dates.DetermineAge("Pension Scheme Join","Date Of Leaving");
                     IF ("Medical Scheme Join" <> 0D) AND ("Date Of Leaving" <> 0D) THEN
                      "Time Medical Scheme":= Dates.DetermineAge("Medical Scheme Join","Date Of Leaving");


                     IF ("Date Of Leaving" <> 0D) AND ("Date Of Leaving" <> xRec."Date Of Leaving") THEN BEGIN
                        ExitInterviews.SETRANGE("Employee No.","No.");
                        OK:= ExitInterviews.FIND('-');
                        IF OK THEN BEGIN
                          ExitInterviews."Date Of Leaving":= "Date Of Leaving";
                          ExitInterviews.MODIFY;
                        END;
                        COMMIT();
                     END;


                    IF ("Date Of Leaving" <> 0D) AND ("Date Of Leaving" <> xRec."Date Of Leaving") THEN BEGIN
                       CareerEvent.SetMessage('Left The Company');
                       CareerEvent.RUNMODAL;
                       OK:= CareerEvent.ReturnResult;
                        IF OK THEN BEGIN
                           CareerHistory.INIT;
                           IF NOT CareerHistory.FIND('-') THEN
                            CareerHistory."Line No.":=1
                          ELSE BEGIN
                            CareerHistory.FIND('+');
                            CareerHistory."Line No.":=CareerHistory."Line No."+1;
                          END;

                           CareerHistory."Employee No.":= "No.";
                           CareerHistory."Date Of Event":= "Date Of Leaving";
                           CareerHistory."Career Event":= 'Left The Company';
                           CareerHistory."Employee First Name":= "Known As";
                           CareerHistory."Employee Last Name":= "Last Name";

                           CareerHistory.INSERT;
                        END;
                    END;
                   */
                /*
                    ExitInterviewTemplate.RESET;
                    //TrainingEvalTemplate.SETRANGE(TrainingEvalTemplate."AIT/Evaluation",TrainingEvalTemplate."AIT/Evaluation"::AIT);
                    IF ExitInterviewTemplate.FIND('-') THEN
                    REPEAT
                    ExitInterviewLines.INIT;
                    ExitInterviewLines."Employee No":="No.";
                    ExitInterviewLines.Question:=ExitInterviewTemplate.Question;
                    ExitInterviewLines."Line No":=ExitInterviewTemplate."Line No";
                    ExitInterviewLines.Bold:=ExitInterviewTemplate.Bold;
                    ExitInterviewLines."Answer Type":=ExitInterviewTemplate."Answer Type";
                    IF NOT ExitInterviewLines.GET(ExitInterviewLines."Line No",ExitInterviewLines."Employee No") THEN
                    ExitInterviewLines.INSERT


                    UNTIL ExitInterviewTemplate.NEXT=0;
                    */
            end;
        }
        field(50048; "Second Language (R/W/S)"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(50049; "Additional Language"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(50050; "Termination Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Resignation,Non-Renewal Of Contract,Dismissal,Retirement,Death,Other';
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
                //**Added by ACR 12/08/2002
                //**Block resource if Terminated
                if "Resource No." <> '' then begin
                    OK := "Lrec Resource".Get("Resource No.");
                    "Lrec Resource".Blocked := true;
                    "Lrec Resource".Modify;
                end;
                //**
            end;
        }
        field(50051; "Passport Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50058; "HELB No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50059; "Co-Operative No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50061; "Succesion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50062; "Send Alert to"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50063; Religion; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Religion;
        }
        field(50064; "Served Notice Period"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50065; "Exit Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50066; "Exit Interview Done by"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(50067; "Allow Re-Employment In Future"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50068; "Incremental Month"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50069; "Current Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50070; Present; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer"."Salary Pointer" WHERE("Salary Scale" = FIELD("Salary Scale"));

            trigger OnValidate()
            begin
                DefaultAssignment();
            end;
        }
        field(50071; Previous; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer";
        }
        field(50072; Halt; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salary Pointer";
        }
        field(50074; "Insurance Premium"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = CONST(Deduction), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Insurance Code" = CONST(true)));
            FieldClass = FlowField;
        }
        field(50075; "Date OfJoining Payroll"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50076; "Pro-Rata Calculated"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50077; "Basic Arrears"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = CONST(Payment), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Basic Pay Arrears" = CONST(true)));
            FieldClass = FlowField;
        }
        field(50078; "Relief Amount"; Decimal)
        {
            CalcFormula = - Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Non-Cash Benefit" = CONST(true), Type = CONST(Payment), "Tax Deductible" = CONST(true), "Tax Relief" = CONST(true)));
            FieldClass = FlowField;
        }
        field(50079; "Employee Qty"; Integer)
        {
            CalcFormula = Count(Employee);
            FieldClass = FlowField;
        }
        field(50080; "Employee Act. Qty"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Termination Category" = FILTER(= " ")));
            FieldClass = FlowField;
        }
        field(50081; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Termination Category" = FILTER(<> " ")));
            FieldClass = FlowField;
        }
        field(50082; "Other Language Read"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50083; "Other Language Write"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50084; "Other Language Speak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50085; "Employee Job Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = '  ,Driver,Executive,Director';
            OptionMembers = "  ",Driver,Executive,Director;
        }
        field(50087; "Contract Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50186; "Loan Interest"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Loan Interest" WHERE(Type = FILTER(Deduction | Loan), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter")));
            FieldClass = FlowField;
        }
        field(50187; "Resource Centre"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50188; "Resource Request Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Cancelled';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Cancelled;
        }
        field(50189; "Blood Type"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50190; Disability; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50191; "County Code"; Code[30])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
            TableRelation = CountyNew."County Code";

            trigger OnValidate()
            var
                cty: Record CountyNew;
            begin
                cty.SetRange("County Code", "County Code");
                if cty.FindFirst() then "County Name" := cty.County;
            end;
        }
        field(50192; "Retirement Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50193; "Medical Member No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50194; "Exit Ref No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50195; "Human Resouce Manager"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50196; "Hours Worked"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50198; "Lost Book"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50199; "House Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = CONST(Payment), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "House Allowance Code" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50200; Company; Text[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Company;
        }
        field(50201; "Min Tax Rate"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50202; "Acting Position"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50203; "Acting No"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50204; "Acting Description"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50205; "Relieved Employee"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50206; "Relieved Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(50207; "Reason for Acting"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50208; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50209; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50210; "Disability Certificate"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50212; "Pension Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55000; "No. of Members"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(55001; "Status Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Open,Pending Approval,Active,Canceled,Rejected,Inactive,Deferred,Claim Processing,Archived';
            OptionMembers = Open,"Pending Approval",Active,Canceled,Rejected,Inactive,Deferred,"Claim Processing",Archived;
        }
        field(60000; Name; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Employment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Active,Inactive,Permanently Inactive';
            OptionMembers = Active,Inactive,"Permanently Inactive";

            trigger OnValidate()
            begin
                /* HumanResSetup.GET;
                     HumanResSetup.TESTFIELD("Maximum Probation Period");
                      IF "Employment Status"="Employment Status"::"Extended Probation" THEN
                      "End Of Probation Date":=CALCDATE(HumanResSetup."Maximum Probation Period","Date Of Join");
                     */
            end;
        }
        field(60002; "Contract Length"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                    IF "Contract Type"="Contract Type"::"Long-Term" THEN
                      "Contract Length">'<6M>' ELSE
                      ERROR('The Contract Period Should be Greater than 6 Months');
                    */
            end;
        }
        field(60004; "Portal Registered"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60005; "Activation Code"; Guid)
        {
            DataClassification = ToBeClassified;
        }
        field(60006; "Payroll Suspenstion Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60007; "Payroll Reactivation Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(60008; "Employee Type"; Option)
        {
            ObsoleteState = Removed;
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract,Board Member,Attachee, Intern';
            OptionMembers = Permanent,Partime,Locum,Casual,Contract,Trustee,Attachee,Intern;
        }
        field(60009; "Currency Codes"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "Net Pay"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Non-Cash Benefit" = CONST(false), Gratuity = CONST(false), "Tax Relief" = CONST(false)));
            FieldClass = FlowField;
        }
        field(60011; "Employment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Partime,Casual,Contract,Board member,Attachee,Intern';
            OptionMembers = Permanent,Partime,Casual,Contract,Trustee,Attachee,Intern;
        }
        field(60012; "Area"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60013; "Ethnic Community"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Ethnic Communities";

            trigger OnValidate()
            begin
                if Ethnic.Get("Ethnic Community") then "Ethnic Name" := Ethnic."Ethnic Name";
            end;
        }
        field(60014; "Ethnic Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(60015; "Home District"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Districts;
        }
        field(60017; "Employee Bank Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60018; "Employee Bank Sort Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(60019; "Employee Branch Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60020; "Insurance Relief"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60021; "Commuter Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = CONST(Payment), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Commuter Allowance Code" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60022; "Salary Arrears"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type = CONST(Payment), "Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Salary Arrears Code" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60023; "Debtor Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer where(PML = const(false));
        }
        field(50100; "Imprest Customer Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(60024; "Current Leave Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Leave Periods" WHERE("Employment Type" = FIELD("Employment Type"), closed = FILTER(false));
        }
        field(60025; "Leave Balance"; Decimal)
        {
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."), "Leave Period Code" = FIELD("Current Leave Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60026; "Secondary Employee"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60027; "Cumm. Secondary  PAYE"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "Secondary PAYE" = CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(60028; "Total Leave Balance"; Decimal)
        {
            FieldClass = FlowField;
            Editable = false;
            Description = 'With Flowfilters';
            CalcFormula = Sum("HR Leave Ledger Entries"."No. of days" WHERE("Staff No." = FIELD("No."), "Leave Period Code" = FIELD("Leave Period Filter"), "Leave Type" = FIELD("Leave Type Filter")));
        }
        field(60029; "Gratuity Vendor No."; code[50])
        {
            TableRelation = Vendor;
            DataClassification = ToBeClassified;
        }
        field(60030; "County Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60031; "Huduma Number"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60032; "Alternative Branch Code"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value" where("Global Dimension No." = filter(1));
        }
        field(60033; Race; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60034; "Job Title2"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(60035; "Special Retirement Age"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                HRSetup: Record "Human Resources Setup";
            begin
                HRSetup.Get();
                HRSetup.TestField("Other Retirement Age");
            end;
        }
        field(60036; "Pension Contribution Benefit"; Decimal)
        {
            CalcFormula = - Sum("Assignment Matrix-X"."Less Pension Contribution" WHERE("Employee No" = FIELD("No."), "Payroll Period" = FIELD("Pay Period Filter"), "PAYE" = CONST(true), Type = CONST(Deduction)));
            FieldClass = FlowField;
        }
        field(60050; "Leave Category"; Code[20])
        {
            Caption = 'Leave Category';
            TableRelation = "Payroll Leave Category";
        }
        field(60055; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60056; "Division/Section"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(60057; "Directorate"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnInsert()
    begin
        if "Employment Type" = "Employment Type"::Trustee then begin
            HumanResSetup.Get();
            HumanResSetup.TestField("Trustee Nos");
        end;
    end;

    var
        HRDates: Codeunit "Dates Management";
        DateMgmt: Codeunit "Dates Management";
        Jobs: Record "Company Job";
        Banks: Record Banks;
        Employee: Record Employee;
        Scale: Record "Salary Scale";
        AssMatrix: Record "Assignment Matrix-X";
        PayPeriod: Record "Payroll PeriodX";
        Begindate: Date;
        ScaleBenefits: Record "Scale Benefits";
        HouseAllowances: Record "House Allowances";
        Ded: Record DeductionsX;
        ContractPeriod: Date;
        EmpContract: Record "Employment Contract";
        Ethnic: Record "Ethnic Communities";
        Branches: Record "Bank Branches";
        UserSetup: Record "User Setup";
        Users: Record User;
        Text0004: Label 'You are not allowed delete an Employee record with payroll entries, you can only Terminate or change status to Inactive';
        Text001: Label 'Do you want to re-assign earnings and deductions to %1 %2 ?';
        Text002: Label 'Please select the present salary pointer or assign a pointer with scale benefits defined for employee %1 %2';
        Text003: Label 'There''s no open pay period open';
        HumanResSetup: Record "Human Resources Setup";
        dateform: DateFormula;

    procedure DefaultAssignment()
    begin
        // if Confirm(Text001, false, "No.", "First Name" + ' ' + "Middle Name" + ' ' + "Last Name") then begin
        //Insert Earnings Based on the Salary Scales
        GetPayPeriod;
        if Begindate <> 0D then begin
            AssMatrix.Init;
            AssMatrix."Employee No" := "No.";
            AssMatrix.Type := AssMatrix.Type::Payment;
            AssMatrix."Payroll Period" := Begindate;
            AssMatrix."Department Code" := "Global Dimension 1 Code";
            ScaleBenefits.Reset;
            ScaleBenefits.SetRange("Salary Scale", "Salary Scale");
            ScaleBenefits.SetRange("Salary Pointer", Present);
            ScaleBenefits.SetRange("Based on branches", false);
            if ScaleBenefits.Find('-') then begin
                repeat
                    AssMatrix.Code := ScaleBenefits."ED Code";
                    AssMatrix.Description := ScaleBenefits."ED Description";
                    AssMatrix.Validate(Code);
                    AssMatrix.Amount := ScaleBenefits.Amount;
                    AssMatrix.Validate(Amount);
                    if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period", AssMatrix."Reference No") then
                        AssMatrix.Insert
                    else begin
                        AssMatrix.Code := ScaleBenefits."ED Code";
                        AssMatrix.Validate(Code);
                        AssMatrix.Amount := ScaleBenefits.Amount;
                        AssMatrix.Validate(Amount);
                        AssMatrix.Modify;
                    end;
                until ScaleBenefits.Next = 0;
            end
            else
                Error(Text002, "No.", "First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
            //insert branch based earnings
            ScaleBenefits.Reset;
            ScaleBenefits.SetRange("Salary Scale", "Salary Scale");
            ScaleBenefits.SetRange("Salary Pointer", Present);
            ScaleBenefits.SetRange("Based on branches", true);
            if ScaleBenefits.Find('-') then begin
                repeat
                    HouseAllowances.reset;
                    HouseAllowances.SetRange("Job group", ScaleBenefits."Salary Scale");
                    HouseAllowances.SetRange(Pointer, ScaleBenefits."Salary Pointer");
                    HouseAllowances.SetRange(Branch, "Global Dimension 1 Code");
                    HouseAllowances.SetRange(Code, ScaleBenefits."ED Code");
                    if HouseAllowances.Find('-') then
                        repeat
                            AssMatrix.Code := ScaleBenefits."ED Code";
                            AssMatrix.Description := ScaleBenefits."ED Description";
                            AssMatrix.Validate(Code);
                            AssMatrix.Amount := HouseAllowances.Amount;
                            AssMatrix.Validate(Amount);
                            if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period", AssMatrix."Reference No") then
                                AssMatrix.Insert
                            else begin
                                AssMatrix.Code := ScaleBenefits."ED Code";
                                AssMatrix.Validate(Code);
                                AssMatrix.Amount := ScaleBenefits.Amount;
                                AssMatrix.Validate(Amount);
                                AssMatrix.Modify;
                            end;
                        until HouseAllowances.Next = 0;
                until ScaleBenefits.Next = 0;
            end;
            // Insert Deductions assigned to evry employee
            Ded.Reset;
            Ded.SetRange("Applies to All", true);
            if Ded.Find('-') then begin
                repeat
                    AssMatrix.Init;
                    AssMatrix."Employee No" := "No.";
                    AssMatrix.Type := AssMatrix.Type::Deduction;
                    AssMatrix."Payroll Period" := Begindate;
                    AssMatrix."Department Code" := "Global Dimension 1 Code";
                    AssMatrix.Code := Ded.Code;
                    AssMatrix.Validate(Code);
                    if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period") then
                        AssMatrix.Insert
                    else begin
                        AssMatrix.Code := Ded.Code;
                        AssMatrix.Validate(Code);
                    end;
                until Ded.Next = 0;
            end;
        end
        else
            Error(Text003);
        // end;
    end;

    procedure GetPayPeriod()
    begin
        PayPeriod.Reset;
        PayPeriod.SetRange(PayPeriod."Close Pay", false);
        if PayPeriod.Find('-') then begin
            //PayPeriodtext:=PayPeriod.Name;
            Begindate := PayPeriod."Starting Date";
            //MESSAGE('%1',Begindate);
        end;
    end;
}
