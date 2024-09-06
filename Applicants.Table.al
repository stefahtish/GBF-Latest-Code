table 50206 Applicants
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            NotBlank = false;
        }
        field(2; "First Name"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Middle Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Last Name"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Reason: Text[30];
            begin
            end;
        }
        field(5; Initials; Text[15])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Search Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Postal Address"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Residential Address"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(10; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Post Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; County; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Home Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Cellular Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Work Phone Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Ext."; Text[7])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "E-Mail"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(19; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(20; "ID Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(21; Gender; enum "Employee Gender")
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Country Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";
        }
        field(23; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Normal,Resigned,Discharged,Retrenched,Pension,Disabled;
        }
        field(24; Comment; Boolean)
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(25; "Fax Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Marital Status"; Enum "Marital Status")
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Ethnic Origin"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = African,Indian,White,Coloured;
        }
        field(28; "First Language (R/W/S)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Driving Licence"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Disabled; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = No,Yes," ";
        }
        field(31; "Health Assesment?"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Health Assesment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Date Of Birth"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                Text001: label '%1 %2 cannot be greater than Today %3.';
            begin
                if "Date of Birth" > Today then Error(Text001, FieldCaption("Date of Birth"), Format("Date of Birth"), Format(Today));
                Age := Dates.DetermineAge("Date Of Birth", Today);
            end;
        }
        field(34; Age; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Second Language (R/W/S)"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Additional Language"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Primary Skills Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(38; Level; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Level 1","Level 2","Level 3","Level 4","Level 5","Level 6","Level 7";
        }
        field(39; "Termination Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Resignation,"Non-Renewal Of Contract",Dismissal,Retirement,Death,Other;

            trigger OnValidate()
            var
                "Lrec Resource": Record Resource;
                OK: Boolean;
            begin
            end;
        }
        field(40; "Postal Address2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Postal Address3"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Residential Address2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Residential Address3"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Post Code2"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Post Code";
        }
        field(45; Citizenship; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region".Code;
        }
        field(46; "Disabling Details"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Disability Grade"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Passport Number"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "2nd Skills Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(50; "3rd Skills Category"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Auditors,Consultants,Training,Certification,Administration,Marketing,Management,"Business Development",Other;
        }
        field(51; Region; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4));
        }
        field(52; "First Language Read"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "First Language Write"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "First Language Speak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Second Language Read"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Second Language Write"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Second Language Speak"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(58; "PIN Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Job Applied For"; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;
            TableRelation = "Company Job";

            trigger OnValidate()
            begin
                Jobs.Reset;
                Jobs.SetRange("Job ID", "Job Applied For");
                if Jobs.Find('-') then begin
                    "Job Description" := Jobs."Job Description";
                    Practical := Jobs.Practical;
                    Classroom := Jobs.Classroom;
                    "Oral (Board)" := Jobs."Oral Interview (Board)";
                    Oral := Jobs."Oral Interview";
                end;
            end;
        }
        field(60; "Need Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Recruitment Needs"."No." WHERE(Status = CONST(Released));

            trigger OnValidate()
            begin
                Needs.Reset;
                Needs.SetRange(Needs."No.", "Need Code");
                if Needs.Find('-') then begin
                    "Job Applied For" := Needs."Job ID";
                    "Job Description" := Needs.Description;
                end;
            end;
        }
        field(61; "Total Score"; Decimal)
        {
            CalcFormula = Sum("Applicants Qualification".Score WHERE(No = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(62; Shortlist; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(63; Employ; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Jobs.Get("Job Applied For") then begin
                    Oral := Jobs."Oral Interview";
                    "Oral (Board)" := Jobs."Oral Interview (Board)";
                    Classroom := Jobs.Classroom;
                    Practical := Jobs.Practical;
                    Modify;
                end;
            end;
        }
        field(64; Stage; Code[20])
        {
            FieldClass = FlowFilter;
        }
        field(65; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "No. Series";
        }
        field(66; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                if "Applicant Type" = "Applicant Type"::External then
                    "Employee No" := ''
                else begin
                    Employee.Reset;
                    Employee.SetRange(Employee."No.", "Employee No");
                    if Employee.Find('-') then begin
                        "First Name" := Employee."First Name";
                        "Middle Name" := Employee."Middle Name";
                        "Last Name" := Employee."Last Name";
                        //Initials:=Employee.Initials;
                        //"Search Name":=Employee."Search Name";
                        "Postal Address" := Employee.Address;
                        //"Residential Address":=Employee."Residential Address";
                        City := Employee.City;
                        "Post Code" := Employee."Post Code";
                        County := Employee.County;
                        "Home Phone Number" := Employee."Phone No.";
                        "Cellular Phone Number" := Employee."Mobile Phone No.";
                        //"Work Phone Number":=Employee."Work Phone Number";
                        "Ext." := Employee.Extension;
                        "E-Mail" := Employee."E-Mail";
                        "ID Number" := Employee."ID No.";
                        Gender := Employee.Gender;
                        "Country Code" := Employee."Country/Region Code";
                        "Fax Number" := Employee."Fax No.";
                        "Marital Status" := Employee."Marital Status";
                        "Ethnic Origin" := Employee."Ethnic Origin";
                        "First Language (R/W/S)" := Employee."First Language (R/W/S)";
                        "Driving Licence" := Employee."Driving Licence";
                        //Disabled:=Employee.Disabled;
                        //"Health Assesment?":=Employee."Health Assesment?";
                        //"Health Assesment Date":=Employee."Health Assesment Date";
                        "Date Of Birth" := Employee."Birth Date";
                        //Age:=Employee.Age;
                        "Second Language (R/W/S)" := Employee."Second Language (R/W/S)";
                        "Additional Language" := Employee."Additional Language";
                        //"Postal Address2":=Employee."Postal Address2";
                        //"Postal Address3":=Employee."Postal Address3";
                        //"Residential Address2":=Employee."Residential Address2";
                        //"Residential Address3":=Employee."Residential Address3";
                        //"Post Code2":=Employee."Post Code2";
                        //Citizenship:=Employee.Citizenship;
                        //"Passport Number":=Employee."Passport Number";
                        "First Language Read" := Employee."First Language Read";
                        "First Language Write" := Employee."First Language Write";
                        "First Language Speak" := Employee."First Language Speak";
                        "Second Language Read" := Employee."Second Language Read";
                        "Second Language Write" := Employee."Second Language Write";
                        "Second Language Speak" := Employee."Second Language Speak";
                        "PIN Number" := Employee."PIN Number";
                        //"Country Code":=Employee."Country Code";
                        //"Applicant Type":="Applicant Type"::Internal;
                        EmpQualifications.Reset;
                        EmpQualifications.SetRange(EmpQualifications."Employee No.", Employee."No.");
                        if EmpQualifications.Find('-') then begin
                            repeat
                                AppQualifications."Employee No." := "No.";
                                //AppQualifications."Qualification Type":=EmpQualifications."Qualification Type";
                                AppQualifications."Qualification Code" := EmpQualifications."Qualification Code";
                                AppQualifications."From Date" := EmpQualifications."From Date";
                                AppQualifications."To Date" := EmpQualifications."To Date";
                                AppQualifications.Type := EmpQualifications.Type;
                                AppQualifications.Description := EmpQualifications.Description;
                                AppQualifications.Institution_Company := EmpQualifications."Institution/Company";
                                //AppQualifications.CourseType:=EmpQualifications.CourseType;
                                //AppQualifications.Score:=EmpQualifications.Grade;
                                AppQualifications.Comment := EmpQualifications.Comment;
                                AppQualifications.Insert(true);
                            until EmpQualifications.Next = 0
                        end
                    end
                end;
            end;
        }
        field(67; "Applicant Type"; Option)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            OptionCaption = 'External,Internal';
            OptionMembers = External,Internal;

            trigger OnValidate()
            begin
                if "Applicant Type" = "Applicant Type"::External then "Employee No" := '';
            end;
        }
        field(68; "Application Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Job Description"; Text[200])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70; "Interview Score"; Decimal)
        {
            CalcFormula = Average("Interview Stage"."Marks Awarded" WHERE("Applicant No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(71; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));

            trigger OnValidate()
            begin
                //ValidateShortcutDimCode(1,"Global Dimension 1 Code");
            end;
        }
        field(72; "Application No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value";
        }
        field(73; "Hobby No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                /*
                    Applicants.RESET;
                    Applicants.SETRANGE("No.","No.");
                    IF Applicants.FIND('-') THEN
                      BEGIN
                        IF "Hobby No."<>0 THEN
                          BEGIN
                            "Hobby No.":="Hobby No."+1
                          END ELSE
                            IF "Hobby No."=0 THEN
                              "Hobby No.":=1;
                      END;
                    */
            end;
        }
        field(74; Hobbies; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(75; Notified; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //IF Notified THEN
                //BEGIN
                if CompanyJob.Get("Job Applied For") then Oral := CompanyJob."Oral Interview";
                "Oral (Board)" := CompanyJob."Oral Interview (Board)";
                Classroom := CompanyJob.Classroom;
                Practical := CompanyJob.Practical;
                Modify;
                // END;
            end;
        }
        field(76; Applied; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(77; Interviewed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(78; Qualified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(79; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Interview Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(81; "Interview Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(82; "Expected Reporting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(83; Oral; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(84; "Oral (Board)"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(85; Practical; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(86; Classroom; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(87; "Practical Score"; Decimal)
        {
            CalcFormula = Average("Practical Interview".Score WHERE("Applicant No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(88; "Classroom Score"; Decimal)
        {
            CalcFormula = Average("Classroom Interview".Score WHERE("Applicant No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(89; "Oral Score"; Decimal)
        {
            CalcFormula = Average("Oral Interview".Score WHERE("Applicant No" = FIELD("No.")));
            FieldClass = FlowField;
        }
        field(90; "Oral (Board) Score"; Decimal)
        {
            CalcFormula = Average("Oral Interview (Board)".Score WHERE("Applicant No" = FIELD("No.")));
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "No.", "Need Code")
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
            HRSetup.TestField("Applicants Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Applicants Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;

    var
        Needs: Record "Recruitment Needs";
        Employee: Record Employee;
        HumanResSetup: Record "Human Resources Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        EmpQualifications: Record "Employee Qualification";
        AppQualifications: Record "Applicants Qualification";
        HRSetup: Record "Human Resources Setup";
        Jobs: Record "Company Job";
        Dates: Codeunit "Dates ManagementHR";
        Applicants: Record Applicants;
        HobNo: Code[20];
        CompanyJob: Record "Company Job";
}
