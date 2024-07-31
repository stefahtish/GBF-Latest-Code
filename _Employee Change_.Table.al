table 50289 "Employee Change"
{
    Caption = 'Employee';
    DataCaptionFields = "No.", "First Name", "Middle Name", "Last Name";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';

            trigger OnValidate()
            begin
                if "No." <> xRec."No." then begin
                    HumanResSetup.Get;
                    NoSeriesMgt.TestManual(HumanResSetup."Employee Nos.");
                    "No. Series":='';
                end;
            end;
        }
        field(2; "First Name"; Text[30])
        {
            Caption = 'First Name';
        }
        field(3; "Middle Name"; Text[30])
        {
            Caption = 'Middle Name';
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
        }
        field(5; Initials; Text[30])
        {
            Caption = 'Initials';

            trigger OnValidate()
            begin
                if("Search Name" = UpperCase(xRec.Initials)) or ("Search Name" = '')then "Search Name":=Initials;
            end;
        }
        field(6; "Job Title"; Text[30])
        {
            Caption = 'Job Title';
        }
        field(7; "Search Name"; Code[100])
        {
            Caption = 'Search Name';

            trigger OnValidate()
            begin
                if "Search Name" = '' then "Search Name":=SetSearchNameToFullnameAndInitials;
            end;
        }
        field(8; Address; Text[50])
        {
            Caption = 'Address';
        }
        field(9; "Address 2"; Text[50])
        {
            Caption = 'Address 2';
        }
        field(10; City; Text[30])
        {
            Caption = 'City';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code".City
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code".City WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidateCity(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(11; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
                if PostCode.Get(PostCode.Code)then begin
                    City:=PostCode."Search City";
                end;
            end;
        }
        field(12; County; Text[30])
        {
            Caption = 'County';
        }
        field(13; "Phone No."; Text[30])
        {
            Caption = 'Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(14; "Mobile Phone No."; Text[30])
        {
            Caption = 'Mobile Phone No.';
            ExtendedDatatype = PhoneNo;
        }
        field(15; "E-Mail"; Text[80])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("E-Mail");
            end;
        }
        field(16; "Alt. Address Code"; Code[10])
        {
            Caption = 'Alt. Address Code';
            TableRelation = "Alternative Address".Code WHERE("Employee No."=FIELD("No."));
        }
        field(17; "Alt. Address Start Date"; Date)
        {
            Caption = 'Alt. Address Start Date';
        }
        field(18; "Alt. Address End Date"; Date)
        {
            Caption = 'Alt. Address End Date';
        }
        field(19; Picture; BLOB)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(20; "Date of Birth"; Date)
        {
            Caption = 'Birth Date';

            trigger OnValidate()
            var
                RetirementAge: Text;
            begin
                HumanResSetup.Get;
                "Date of Birth - Age":=HRDates.DetermineAge("Date of Birth", Today);
                "Retirement Date":=CalcDate(HumanResSetup."Years To Retire", "Date of Birth");
            end;
        }
        field(21; "Social Security No."; Text[30])
        {
            Caption = 'Social Security No.';
        }
        field(22; "Union Code"; Code[10])
        {
            Caption = 'Union Code';
            TableRelation = Union;
        }
        field(23; "Union Membership No."; Text[30])
        {
            Caption = 'Union Membership No.';
        }
        field(24; Gender; Option)
        {
            Caption = 'Gender';
            OptionCaption = ' ,Female,Male';
            OptionMembers = " ", Female, Male;
        }
        field(25; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(26; "Manager No."; Code[20])
        {
            Caption = 'Manager No.';
            TableRelation = Employee;
        }
        field(27; "Emplymt. Contract Code"; Code[10])
        {
            Caption = 'Emplymt. Contract Code';
            TableRelation = "Employment Contract";
        }
        field(28; "Statistics Group Code"; Code[10])
        {
            Caption = 'Statistics Group Code';
            TableRelation = "Employee Statistics Group";
        }
        field(29; "Employment Date"; Date)
        {
            Caption = 'Employment Date';

            trigger OnValidate()
            begin
                "Employment Date - Age":=HRDates.DetermineAge("Employment Date", Today);
            end;
        }
        field(31; Status; Option)
        {
            Caption = 'Status';
            OptionCaption = 'Active,Dormant,Probation,Terminated,Retired,Deceased,Resigned';
            OptionMembers = Active, Dormant, Probation, Terminated, Retired, Deceased, Resigned;

            trigger OnValidate()
            begin
            // EmployeeQualification.SETRANGE("Employee No.","No.");
            // EmployeeQualification.MODIFYALL("Employee Status",Status);
            // MODIFY;
            end;
        }
        field(32; "Inactive Date"; Date)
        {
            Caption = 'Inactive Date';
        }
        field(33; "Cause of Inactivity Code"; Code[10])
        {
            Caption = 'Cause of Inactivity Code';
            TableRelation = "Cause of Inactivity";
        }
        field(34; "Termination Date"; Date)
        {
            Caption = 'Termination Date';
        }
        field(35; "Grounds for Term. Code"; Code[10])
        {
            Caption = 'Grounds for Term. Code';
            TableRelation = "Grounds for Termination";
        }
        field(36; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Global Dimension 1 Code");
            end;
        }
        field(37; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Global Dimension 2 Code");
            end;
        }
        field(38; "Resource No."; Code[20])
        {
            Caption = 'Resource No.';
            TableRelation = Resource WHERE(Type=CONST(Person));

            trigger OnValidate()
            begin
            /*
                IF ("Resource No." <> '') AND Res.WRITEPERMISSION THEN
                  EmployeeResUpdate.ResUpdate(Rec)
                */
            end;
        }
        field(39; Comment; Boolean)
        {
            CalcFormula = Exist("Human Resource Comment Line" WHERE("Table Name"=CONST(Employee), "No."=FIELD("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(40; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(41; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(42; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(43; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(44; "Cause of Absence Filter"; Code[10])
        {
            Caption = 'Cause of Absence Filter';
            FieldClass = FlowFilter;
            TableRelation = "Cause of Absence";
        }
        field(45; "Total Absence (Base)"; Decimal)
        {
            CalcFormula = Sum("Employee Absence"."Quantity (Base)" WHERE("Employee No."=FIELD("No."), "Cause of Absence Code"=FIELD("Cause of Absence Filter"), "From Date"=FIELD("Date Filter")));
            Caption = 'Total Absence (Base)';
            DecimalPlaces = 0: 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(46; Extension; Text[30])
        {
            Caption = 'Extension';
        }
        field(47; "Employee No. Filter"; Code[20])
        {
            Caption = 'Employee No. Filter';
            FieldClass = FlowFilter;
            TableRelation = Employee;
        }
        field(48; Pager; Text[30])
        {
            Caption = 'Pager';
        }
        field(49; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
        }
        field(50; "Company E-Mail"; Text[50])
        {
            Caption = 'Company Email';
            ExtendedDatatype = EMail;

            trigger OnValidate()
            var
                MailManagement: Codeunit "Mail Management";
            begin
                MailManagement.ValidateEmailAddressField("Company E-Mail");
            end;
        }
        field(51; Title; Text[30])
        {
            Caption = 'Title';
        }
        field(52; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salespers./Purch. Code';
            TableRelation = "Salesperson/Purchaser";
        }
        field(53; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(54; "Last Modified Date Time"; DateTime)
        {
            Caption = 'Last Modified Date Time';
            Editable = false;
        }
        field(55; "Employee Posting Group"; Code[20])
        {
            Caption = 'Employee Posting Group';
            TableRelation = "Employee Posting Group";
        }
        field(56; "Bank Branch No."; Text[20])
        {
            Caption = 'Bank Branch No.';
            TableRelation = "Bank Branches" WHERE("Bank Code"=FIELD("Employee's Bank"));
        }
        field(57; "Bank Account No."; Text[30])
        {
            Caption = 'Bank Account No.';
        }
        field(58; IBAN; Code[50])
        {
            Caption = 'IBAN';

            trigger OnValidate()
            var
                CompanyInfo: Record "Company Information";
            begin
                CompanyInfo.CheckIBAN(IBAN);
            end;
        }
        field(59; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = -Sum("Detailed Employee Ledger Entry".Amount WHERE("Employee No."=FIELD("No."), "Initial Entry Global Dim. 1"=FIELD("Global Dimension 1 Filter"), "Initial Entry Global Dim. 2"=FIELD("Global Dimension 2 Filter"), "Posting Date"=FIELD("Date Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(60; "SWIFT Code"; Code[20])
        {
            Caption = 'SWIFT Code';
        }
        field(61; "Bank Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;
        }
        field(62; "ID No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Passport No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Application Method"; Option)
        {
            Caption = 'Application Method';
            OptionCaption = 'Manual,Apply to Oldest';
            OptionMembers = Manual, "Apply to Oldest";
        }
        field(81; "Date of Birth - Age"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(82; Password; Code[20])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(83; "Nature of Employment"; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Employment Contract".Code;

            trigger OnValidate()
            begin
                if EmpContract.Get("Nature of Employment")then "Employee Type":=EmpContract."Employee Type" end;
        }
        field(84; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                ContractPeriod:=CalcDate("Contract Length", "Contract Start Date");
                "Contract End Date":=ContractPeriod;
            end;
        }
        field(85; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(86; "Employment Date - Age"; Text[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(140; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
        }
        field(150; "Privacy Blocked"; Boolean)
        {
            Caption = 'Privacy Blocked';
        }
        field(153; "First Language"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(154; "Second Language"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(155; "First Language Read"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(156; "First Language Write"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(157; "First Language Speak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(158; "Second Language Read"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(159; "Second Language Write"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(160; "Second Language Speak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(161; "Other Language"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(170; "Job Position"; Code[40])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                if Jobs.Get("Job Position")then begin
                    "Job Title":=Jobs."Job Description";
                end;
            end;
        }
        field(171; "Job Position Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(180; "Annual Leave Days"; Decimal)
        {
            FieldClass = Normal;
        }
        field(181; "Compassionate Leave Days"; Decimal)
        {
        }
        field(182; "Maternity Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(183; "Paternity Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(184; "Sick Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(185; "Study Leave Days"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(186; "Other Leave Days (Total)"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(187; "Leave Period Filter"; Code[20])
        {
            FieldClass = Normal;
        }
        field(188; "Leave Type Filter"; Code[20])
        {
            FieldClass = Normal;
        }
        field(189; "Reimbursed Leave Days"; Decimal)
        {
            FieldClass = Normal;
        }
        field(190; "Cash - Leave Earned"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(191; "Cash Per Leave Day"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(1100; "Cost Center Code"; Code[20])
        {
            Caption = 'Cost Center Code';
            TableRelation = "Cost Center";
        }
        field(1101; "Cost Object Code"; Code[20])
        {
            Caption = 'Cost Object Code';
            TableRelation = "Cost Object";
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8001; Signature; MediaSet)
        {
            DataClassification = ToBeClassified;
        }
        field(8002; "Lecturer Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Full-Time,Part-Time';
            OptionMembers = " ", "Full-Time", "Part-Time";
        }
        field(8003; "Lecturer Password"; Code[100])
        {
            DataClassification = ToBeClassified;
            ExtendedDatatype = Masked;
        }
        field(8004; "Is Lecturer"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8005; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup"."User ID";
        }
        field(9000; Disabled; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,No,Yes';
            OptionMembers = " ", No, Yes;
        }
        field(9002; "NSSF No."; Code[20])
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
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Basic Salary Code"=CONST(true)));
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
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false), "Normal Earnings"=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50006; "Taxable Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Taxable=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50007; "Total Deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50008; "Employee's Bank"; Code[80])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks.Code;

            trigger OnValidate()
            begin
                if Banks.Get("Employee's Bank")then "Employee Bank Name":=Banks.Name;
            end;
        }
        field(50009; "Bank Branch"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" WHERE("Bank Code"=FIELD("Employee's Bank"));

            trigger OnValidate()
            begin
                if Branches.Get("Employee's Bank", "Bank Branch")then "Employee Branch Name":=Branches."Branch Name";
                "Employee Bank Sort Code":="Employee's Bank" + "Bank Branch";
            end;
        }
        field(50010; "Bank Account Number"; Code[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50011; "Posting Group"; Code[10])
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
                if Scale.Get("Salary Scale")then Halt:=Scale."Maximum Pointer";
            end;
        }
        field(50013; "Tax Deductible Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Tax Deductible"=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false)));
            FieldClass = FlowField;
        }
        field(50014; "Pay Period Filter"; Date)
        {
            FieldClass = FlowFilter;
            TableRelation = "Payroll PeriodX";
        }
        field(50015; "SSF Employer to Date"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Employer Amount" WHERE("Tax Deductible"=CONST(true), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter")));
            FieldClass = FlowField;
        }
        field(50016; "PIN Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Cumm. PAYE"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Paye=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50018; "NHIF No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "Benefits-Non Cash"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(true), Type=CONST(Payment), Taxable=CONST(true)));
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
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Type=CONST(Deduction), "Tax Deductible"=CONST(true), Retirement=CONST(false)));
            FieldClass = FlowField;
        }
        field(50022; "Retirement Contribution"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Tax Deductible"=CONST(true), Retirement=CONST(true)));
            FieldClass = FlowField;
        }
        field(50023; "Owner Occupier"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Type=CONST(Payment), "Tax Deductible"=CONST(true)));
            FieldClass = FlowField;
        }
        field(50024; "Total Savings"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), Type=CONST("Saving Scheme"), "Payroll Period"=FIELD("Pay Period Filter")));
            FieldClass = FlowField;
        }
        field(50025; PensionNo; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Share Amount"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), Shares=CONST(true)));
            Caption = 'coop skg fund';
            FieldClass = FlowField;
        }
        field(50027; "Other deductions"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Paye=CONST(false)));
            FieldClass = FlowField;
        }
        field(50028; Interest; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Interest Amount" WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Type=FILTER(Deduction)));
            FieldClass = FlowField;
        }
        field(50029; "Taxable Income"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), Taxable=CONST(true)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50031; Position; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                if Jobs.Get(Position)then "Job Title":=Jobs."Job Description";
                if((xRec.Position <> '') and (Position <> xRec.Position))then begin
                    Jobs.Reset;
                    Jobs.SetRange(Jobs."Job ID", Position);
                    if Jobs.Find('-')then begin
                        "Job Title":=Jobs."Job Description";
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
            OptionMembers = "Full Time", " Part Time";
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
                if EmpContract.Get("Type of Contract")then "Contract Length":=EmpContract.Tenure;
            end;
        }
        field(50035; "Notice Period"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50036; "Marital Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Single,Married,Separated,Divorced,Widow(er),Other';
            OptionMembers = " ", Single, Married, Separated, Divorced, "Widow(er)", Other;
        }
        field(50037; "Ethnic Origin"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'African,Indian,White,Coloured';
            OptionMembers = African, Indian, White, Coloured;
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
                "End Of Probation Date":=CalcDate(HumanResSetup."Probation Period", "Date Of Join");
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
            OptionMembers = " ", Resignation, "Non-Renewal Of Contract", Dismissal, Retirement, Death, Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
                //**Added by ACR 12/08/2002
                //**Block resource if Terminated
                if "Resource No." <> '' then begin
                    OK:="Lrec Resource".Get("Resource No.");
                    "Lrec Resource".Blocked:=true;
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
            TableRelation = "Salary Pointer"."Salary Pointer" WHERE("Salary Scale"=FIELD("Salary Scale"));

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
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Deduction), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Insurance Code"=CONST(true)));
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
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Basic Pay Arrears"=CONST(true)));
            FieldClass = FlowField;
        }
        field(50078; "Relief Amount"; Decimal)
        {
            CalcFormula = -Sum("Assignment Matrix-X".Amount WHERE("Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(true), Type=CONST(Payment), "Tax Deductible"=CONST(true), "Tax Relief"=CONST(true)));
            FieldClass = FlowField;
        }
        field(50079; "Employee Qty"; Integer)
        {
            CalcFormula = Count(Employee);
            FieldClass = FlowField;
        }
        field(50080; "Employee Act. Qty"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Termination Category"=FILTER(=" ")));
            FieldClass = FlowField;
        }
        field(50081; "Employee Arc. Qty"; Integer)
        {
            CalcFormula = Count(Employee WHERE("Termination Category"=FILTER(<>" ")));
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
            OptionMembers = "  ", Driver, Executive, Director;
        }
        field(50087; "Contract Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50186; "Loan Interest"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X"."Loan Interest" WHERE(Type=FILTER(Deduction|Loan), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter")));
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
            OptionMembers = Open, "Pending Approval", Approved, Rejected, Cancelled;
        }
        field(50189; "Blood Type"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(50190; Disability; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(50191; "County Code"; Code[30])
        {
            DataClassification = ToBeClassified;
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
            FieldClass = Normal;
        }
        field(50199; "House Allowance"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "House Allowance Code"=CONST(true)));
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
        field(50211; "Ethnic Group"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Ethnic Groups";
        }
        field(50212; "Pension Contribution"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(55000; "No. of Members"; Integer)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(55001; "Status Filter"; Option)
        {
            FieldClass = FlowFilter;
            OptionCaption = 'Open,Pending Approval,Active,Canceled,Rejected,Inactive,Deferred,Claim Processing,Archived';
            OptionMembers = Open, "Pending Approval", Active, Canceled, Rejected, Inactive, Deferred, "Claim Processing", Archived;
        }
        field(60000; Name; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(60001; "Employment Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Probation,Extended Probation,Confirmed';
            OptionMembers = Probation, "Extended Probation", Confirmed;

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
        field(60003; "Clearance Department"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Exams,Library,Finance,Dean of Students,Sports,Hostel,Hospital,Dean of School,Dean of Academics,Faculty,Overall';
            OptionMembers = " ", Exams, Library, Finance, "Dean of Students", Sports, Hostel, Hospital, "Dean of School", "Dean of Academics", Faculty, Overall;
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
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Partime,Locum,Casual,Contract';
            OptionMembers = Permanent, Partime, Locum, Casual, Contract;
        }
        field(60009; "Currency Code"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(60010; "Net Pay"; Decimal)
        {
            CalcFormula = Sum("Assignment Matrix-X".Amount WHERE(Type=CONST(Payment), "Employee No"=FIELD("No."), "Payroll Period"=FIELD("Pay Period Filter"), "Non-Cash Benefit"=CONST(false)));
            FieldClass = FlowField;
        }
        field(60011; "Employment Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Contract,Permanent';
            OptionMembers = Contract, Permanent;
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
                if Ethnic.Get("Ethnic Community")then "Ethnic Name":=Ethnic."Ethnic Name";
            end;
        }
        field(60014; "Ethnic Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(60015; "Home District"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(60016; "Employee Company"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'KUC,Utalii Hotel';
            OptionMembers = KUC, "Utalii Hotel";
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
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
        key(Key3; Status, "Union Code")
        {
        }
        key(Key4; Status, "Emplymt. Contract Code")
        {
        }
        key(Key5; "Last Name", "First Name", "Middle Name")
        {
        }
        key(Key6; "Global Dimension 1 Code")
        {
        }
        key(Key7; "Termination Category")
        {
        }
        key(Key8; Position, Status)
        {
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "First Name", "Last Name", Initials, "Job Title")
        {
        }
        fieldgroup(Brick; "Last Name", "First Name", "Job Title", Image)
        {
        }
    }
    trigger OnDelete()
    begin
        AlternativeAddr.SetRange("Employee No.", "No.");
        AlternativeAddr.DeleteAll;
        EmployeeQualification.SetRange("Employee No.", "No.");
        EmployeeQualification.DeleteAll;
        Relative.SetRange("Employee No.", "No.");
        Relative.DeleteAll;
        EmployeeAbsence.SetRange("Employee No.", "No.");
        EmployeeAbsence.DeleteAll;
        MiscArticleInformation.SetRange("Employee No.", "No.");
        MiscArticleInformation.DeleteAll;
        ConfidentialInformation.SetRange("Employee No.", "No.");
        ConfidentialInformation.DeleteAll;
        HumanResComment.SetRange("No.", "No.");
        HumanResComment.DeleteAll;
        DimMgt.DeleteDefaultDim(DATABASE::Employee, "No.");
    end;
    trigger OnInsert()
    begin
        "Last Modified Date Time":=CurrentDateTime;
        if "No." = '' then begin
            HumanResSetup.Get;
            HumanResSetup.TestField("Employee Nos.");
            NoSeriesMgt.InitSeries(HumanResSetup."Employee Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        DimMgt.UpdateDefaultDim(DATABASE::Employee, "No.", "Global Dimension 1 Code", "Global Dimension 2 Code");
        UpdateSearchName;
    end;
    trigger OnModify()
    begin
    /*
        "Last Modified Date Time" := CURRENTDATETIME;
        "Last Date Modified" := TODAY;
        IF Res.READPERMISSION THEN
          EmployeeResUpdate.HumanResToRes(xRec,Rec);
        IF SalespersonPurchaser.READPERMISSION THEN
          EmployeeSalespersonUpdate.HumanResToSalesPerson(xRec,Rec);
        UpdateSearchName;
        */
    end;
    trigger OnRename()
    begin
        "Last Modified Date Time":=CurrentDateTime;
        "Last Date Modified":=Today;
        UpdateSearchName;
    end;
    var HumanResSetup: Record "Human Resources Setup";
    Res: Record Resource;
    PostCode: Record "Post Code";
    AlternativeAddr: Record "Alternative Address";
    EmployeeQualification: Record "Employee Qualification";
    Relative: Record "Employee Relative";
    EmployeeAbsence: Record "Employee Absence";
    MiscArticleInformation: Record "Misc. Article Information";
    ConfidentialInformation: Record "Confidential Information";
    HumanResComment: Record "Human Resource Comment Line";
    SalespersonPurchaser: Record "Salesperson/Purchaser";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    EmployeeResUpdate: Codeunit "Employee/Resource Update";
    EmployeeSalespersonUpdate: Codeunit "Employee/Salesperson Update";
    DimMgt: Codeunit DimensionManagement;
    Text000: Label 'Before you can use Online Map, you must fill in the Online Map Setup window.\See Setting Up Online Map in Help.';
    BlockedEmplForJnrlErr: Label 'You cannot create this document because employee %1 is blocked due to privacy.', Comment = '%1 = employee no.';
    BlockedEmplForJnrlPostingErr: Label 'You cannot post this document because employee %1 is blocked due to privacy.', Comment = '%1 = employee no.';
    HRDates: Codeunit "Dates ManagementHR";
    DateMgmt: Codeunit "Dates ManagementHR";
    Jobs: Record "Company Job";
    Banks: Record Banks;
    Employee: Record Employee;
    Scale: Record "Salary Scale";
    AssMatrix: Record "Assignment Matrix-X";
    Text0004: Label 'You are not allowed delete an Employee record with payroll entries, you can only Terminate or change status to Inactive';
    Text001: Label 'Do you want to re-assign earnings and deductions to %1 %2 ?';
    Text002: Label 'Please select the present salary pointer or assign a pointer with scale benefits defined for employee %1 %2';
    Text003: Label 'There''s no open pay period open';
    PayPeriod: Record "Payroll PeriodX";
    Begindate: Date;
    ScaleBenefits: Record "Scale Benefits";
    Ded: Record DeductionsX;
    ContractPeriod: Date;
    EmpContract: Record "Employment Contract";
    Ethnic: Record "Ethnic Communities";
    Branches: Record "Bank Branches";
    procedure AssistEdit(): Boolean begin
        HumanResSetup.Get;
        HumanResSetup.TestField("Employee Nos.");
        if NoSeriesMgt.SelectSeries(HumanResSetup."Employee Nos.", xRec."No. Series", "No. Series")then begin
            NoSeriesMgt.SetSeries("No.");
            exit(true);
        end;
    end;
    procedure FullName(): Text[100]begin
        if "Middle Name" = '' then exit("First Name" + ' ' + "Last Name");
        exit("First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
    end;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Employee, "No.", FieldNumber, ShortcutDimCode);
        Modify;
    end;
    /*     procedure DisplayMap()
        var
            MapPoint: Record "Online Map Setup";
            MapMgt: Codeunit "Online Map Management";
        begin
            if MapPoint.FindFirst then
                MapMgt.MakeSelection(DATABASE::Employee, GetPosition)
            else
                Message(Text000);
        end; */
    local procedure UpdateSearchName()
    var
        PrevSearchName: Code[250];
    begin
        PrevSearchName:=xRec.FullName + ' ' + xRec.Initials;
        if((("First Name" <> xRec."First Name") or ("Middle Name" <> xRec."Middle Name") or ("Last Name" <> xRec."Last Name") or (Initials <> xRec.Initials)) and ("Search Name" = PrevSearchName))then "Search Name":=SetSearchNameToFullnameAndInitials;
    end;
    local procedure SetSearchNameToFullnameAndInitials(): Code[250]begin
        exit(FullName + ' ' + Initials);
    end;
    procedure GetBankAccountNo(): Text begin
        if IBAN <> '' then exit(DelChr(IBAN, '=<>'));
        if "Bank Account No." <> '' then exit("Bank Account No.");
    end;
    procedure CheckBlockedEmployeeOnJnls(IsPosting: Boolean)
    begin
        if "Privacy Blocked" then begin
            if IsPosting then Error(BlockedEmplForJnrlPostingErr, "No.");
            Error(BlockedEmplForJnrlErr, "No.")end;
    end;
    procedure DefaultAssignment()
    begin
        // if Confirm(Text001, false, "No.", "First Name" + ' ' + "Middle Name" + ' ' + "Last Name") then begin
        //Insert Earnings Based on the Salary Scales
        GetPayPeriod;
        if Begindate <> 0D then begin
            AssMatrix.Init;
            AssMatrix."Employee No":="No.";
            AssMatrix.Type:=AssMatrix.Type::Payment;
            AssMatrix."Payroll Period":=Begindate;
            AssMatrix."Department Code":="Global Dimension 1 Code";
            ScaleBenefits.Reset;
            ScaleBenefits.SetRange("Salary Scale", "Salary Scale");
            ScaleBenefits.SetRange("Salary Pointer", Present);
            if ScaleBenefits.Find('-')then begin
                repeat AssMatrix.Code:=ScaleBenefits."ED Code";
                    AssMatrix.Description:=ScaleBenefits."ED Description";
                    AssMatrix.Validate(Code);
                    AssMatrix.Amount:=ScaleBenefits.Amount;
                    AssMatrix.Validate(Amount);
                    if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period")then AssMatrix.Insert
                    else
                    begin
                        AssMatrix.Code:=ScaleBenefits."ED Code";
                        AssMatrix.Validate(Code);
                        AssMatrix.Amount:=ScaleBenefits.Amount;
                        AssMatrix.Validate(Amount);
                        AssMatrix.Modify;
                    end;
                until ScaleBenefits.Next = 0;
            end
            else
                Error(Text002, "No.", "First Name" + ' ' + "Middle Name" + ' ' + "Last Name");
            // Insert Deductions assigned to evry employee
            Ded.Reset;
            Ded.SetRange("Applies to All", true);
            if Ded.Find('-')then begin
                repeat AssMatrix.Init;
                    AssMatrix."Employee No":="No.";
                    AssMatrix.Type:=AssMatrix.Type::Deduction;
                    AssMatrix."Payroll Period":=Begindate;
                    AssMatrix."Department Code":="Global Dimension 1 Code";
                    AssMatrix.Code:=Ded.Code;
                    AssMatrix.Validate(Code);
                    if not AssMatrix.Get(AssMatrix."Employee No", AssMatrix.Type, AssMatrix.Code, AssMatrix."Payroll Period")then AssMatrix.Insert
                    else
                    begin
                        AssMatrix.Code:=Ded.Code;
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
        if PayPeriod.Find('-')then begin
            //PayPeriodtext:=PayPeriod.Name;
            Begindate:=PayPeriod."Starting Date";
        //MESSAGE('%1',Begindate);
        end;
    end;
}
