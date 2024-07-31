table 50715 "Target Setup Header"
{
    Caption = 'Target Setup Header';
    DrillDownPageId = "Applicants List";
    LookupPageId = "Applicants List";

    fields
    {
        field(1; "Appraisal No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Employee No"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = false;
            TableRelation = Employee."No.";

            trigger OnValidate()
            begin
                Employee.Get("Employee No");
                if Employee."No." = "Employee No" then begin
                    "Appraisee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Appraisee's Job Title":=Employee."Job Position Title";
                    "Job Group":=Employee."Salary Scale";
                    Employee.TestField("Global Dimension 2 Code");
                    //"Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                    // Validate("Shortcut Dimension 1 Code");
                    // "Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                    //Validate("Shortcut Dimension 2 Code");
                    "Date Of Current Designation":=Employee."Employment Date";
                    "Acting Appointments":=Employee."Acting Position";
                    "Terms Of Service":=Employee."Employment Type";
                    "Division/Section":=Employee."Division/Section";
                    Directorate:=Employee.Directorate;
                    Manager:=Employee.Manager;
                end;
            end;
        }
        field(3; "Target No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Appraisal Period"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = "Appraisal Periods".Period where(Closed=CONST(false), Active=const(true));

            trigger OnValidate()
            begin
                //Check if the Appraisal for period has been set 
                EmpAppraisal.Reset;
                EmpAppraisal.SetRange("Employee No", EmpAppraisal."Employee No");
                EmpAppraisal.SetRange("Appraisal Period", EmpAppraisal."Appraisal Period");
                if EmpAppraisal.Find('-')then;
                //Error(Error001, "Employee No", "Appraisal Period");
                if AppraisalPeriods.Get("Appraisal Period")then begin
                    AppraisalPeriods.TestField("Start Date");
                    AppraisalPeriods.TestField("End Date");
                    "Period Start":=AppraisalPeriods."Start Date";
                    "Period End":=AppraisalPeriods."End Date";
                    "Period Description":=AppraisalPeriods.Description;
                    Type:=AppraisalPeriods."Type";
                end;
            end;
        }
        field(5; "No. Supervised (Directly)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "No. Supervised (In-Directly)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Job ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Agreement With Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Entirely, Mostly, "To some extent", "Not at all";
        }
        field(9; "General Comments"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(10; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; Rating; Decimal)
        {
            CalcFormula = Sum("Appraisal Lines"."Total marks per target" WHERE("Appraisal No"=FIELD("Appraisal No")));
            DecimalPlaces = 0: 0;
            FieldClass = FlowField;

            trigger OnValidate()
            begin
            /*
                CALCFIELDS(Rating);
                Grades.RESET;
                Grades.SETRANGE(Points,Rating);
                IF Grades.FIND('-') THEN
                  BEGIN
                    "Rating Description":=Grades.Rating;
                  END;
                */
            end;
        }
        field(12; "Rating Description"; Text[150])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Appraiser No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee where("Employment Status"=CONST(Active), "Status"=CONST(Active));

            trigger OnValidate()
            var
                Employee2: Record Employee;
            begin
                if Employee2.Get("Appraiser No")then begin
                    "Appraisers Name":=Employee."First Name" + ' ' + Employee2."Middle Name" + ' ' + Employee2."Last Name";
                    "Appraiser's Job Title":=Employee2."Job Position Title";
                    "Appraiser ID":=Employee2."User ID";
                end;
            end;
        }
        field(14; "Appraisers Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Appraisee ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Appraiser ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Appraisee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Job Group"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Appraiser's Job Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Appraisee's Job Title"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "No. series"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(27; Status; Option)
        {
            DataClassification = ToBeClassified;
            Editable = true;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Pending Comments Approval,Completed,Mid-Year Approval';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected, "Pending Comments Approval", Completed, "Mid-Year Approved";
        }
        field(28; "Department Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Period Start"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Period End"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Target Score"; Decimal)
        {
            CalcFormula = Sum("Appraisal Lines".Rating WHERE("Appraisal No"=FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(32; "Target Avg"; Decimal)
        {
            CalcFormula = Average("Appraisal Lines".Rating WHERE("Appraisal No"=FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(33; "Target Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Setting,Under Review,Approved';
            OptionMembers = Setting, "Under Review", Approved;
        }
        // field(34; "Values Total"; Decimal)
        // {
        //     CalcFormula = Sum("Appraisal Competences".Score WHERE("Core Value/Competence" = CONST(Values),
        //                                                            "Appraisal No." = FIELD("Appraisal No")));
        //     FieldClass = FlowField;
        // }
        field(35; "Values Mean"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Competences Total"; Decimal)
        {
            CalcFormula = Sum("Appraisal Competences".Score WHERE("Core Value/Competence"=CONST("Core Values/Competences"), "Appraisal No."=FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(37; "Competences Mean"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // field(38; "Curriculum Total"; Decimal)
        // {
        //     CalcFormula = Sum("Appraisal Competences".Score WHERE("Core Value/Competence" = CONST("Curriculum Delivery"),
        //                                                            "Appraisal No." = FIELD("Appraisal No")));
        //     FieldClass = FlowField;
        // }
        field(39; "Curriculum Mean"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // field(40; "Research Total"; Decimal)
        // {
        //     CalcFormula = Sum("Appraisal Competences".Score WHERE("Value/Core Competence" = CONST(Research),
        //                                                            "Appraisal No." = FIELD("Appraisal No")));
        //     FieldClass = FlowField;
        // }
        field(41; "Research Mean"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        // field(42; "Initiative Total"; Decimal)
        // {
        //     CalcFormula = Sum("Appraisal Competences".Score WHERE("Value/Core Competence" = CONST("Initiative & Willingness"),
        //                                                            "Appraisal No." = FIELD("Appraisal No")));
        //     FieldClass = FlowField;
        // }
        field(43; "Initiative Mean"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Managerial Total"; Decimal)
        {
            CalcFormula = Sum("Appraisal Competences".Score WHERE("Core Value/Competence"=CONST("Core Managerial Values/Competence"), "Appraisal No."=FIELD("Appraisal No")));
            FieldClass = FlowField;
        }
        field(45; "Managerial  Mean"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Total Weighting"; Decimal)
        {
            CalcFormula = Sum("Appraisal Lines".Weighting WHERE("Appraisal No"=FIELD("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(47; "Total Mid-Year"; Decimal)
        {
            CalcFormula = Sum("Appraisal Lines"."Mid-Year Appraisal" WHERE("Appraisal No"=FIELD("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "Total Final Self"; Decimal)
        {
            CalcFormula = Sum("Appraisal Lines"."Final Self-Appraisal" WHERE("Appraisal No"=FIELD("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50; "Appraisal Type Description"; Text[150])
        {
            CalcFormula = Lookup("Appraisal Type".Description WHERE(Code=FIELD("Appraisal Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(51; "Responsibilty Center"; Code[20])
        {
            CalcFormula = Lookup("User Setup"."User Responsibility Center" WHERE("Employee No."=FIELD("Employee No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(52; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Mid-Year,Final Year';
            OptionMembers = " ", "Mid-Year", "Final Year";
        }
        field(53; "AppraisalType"; Option)
        {
            Caption = 'Appraisal Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Q1,Q2,Q3,Q4';
            OptionMembers = " ", Q1, Q2, Q3, Q4;
        }
        field(55; "Grade-Attributes"; Text[50])
        {
            Caption = 'Perfomance grade';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(56; "Total Percentage-Attributes"; Decimal)
        {
            Caption = 'Total percentage score';
            DataClassification = ToBeClassified;
            //CalcFormula = Sum("Appraisal - attributes".Rating WHERE("Appraisal No." = FIELD("Appraisal No")));
            Editable = false;

            //FieldClass = FlowField;
            trigger OnValidate()
            begin
                Matrix.Reset();
                Matrix.SetFilter(Start, '<=%1', "Total Percentage-Attributes");
                Matrix.SetFilter("End", '>=%1', "Total Percentage-Attributes");
                IF Matrix.FindFirst()then "Grade-Attributes":=Matrix.Grade;
            end;
        }
        field(58; "Total Percentage FY Rating"; Decimal)
        {
            Caption = 'Total percentage score';
            DataClassification = ToBeClassified;
            //CalcFormula = Sum("Appraisal - attributes".Rating WHERE("Appraisal No." = FIELD("Appraisal No")));
            Editable = false;

            //FieldClass = FlowField;
            trigger OnValidate()
            begin
                Matrix.Reset();
                Matrix.SetFilter(Start, '<=%1', "Total Percentage FY Rating");
                Matrix.SetFilter("End", '>=%1', "Total Percentage FY Rating");
                IF Matrix.FindFirst()then "Grade final year rating":=Matrix.Grade;
            end;
        }
        field(59; "Grade final year rating"; Text[50])
        {
            Caption = 'Perfomance grade';
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(60; "Total score"; Decimal)
        {
            CalcFormula = Sum("Target Setup Lines"."Max Score" WHERE("Target No"=FIELD("Target No"), "Employee No"=field("Employee No"), "Appraisal Period"=field("Appraisal Period")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Total FY Rating"; Decimal)
        {
            CalcFormula = Sum("Appraisal Lines".Rating WHERE("Appraisal No"=FIELD("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Total FY Attributes"; Decimal)
        {
            Caption = 'Total rating';
            CalcFormula = Sum("Appraisal - attributes".Rating WHERE("Appraisal No."=FIELD("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Expected TR -attributes"; Decimal)
        {
            CalcFormula = Sum("Appraisal - attributes"."Expected rating attributes" WHERE("Appraisal No."=FIELD("Appraisal No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(64; "Second Appraiser No."; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                If Employee.Get("Second Appraiser No.")then begin
                    "Second Appraiser Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                    "Second Appraiser Job":=Employee."Job Position Title";
                end;
            end;
        }
        field(65; "Second Appraiser Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Second Appraiser Job"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Directorate"; Text[300])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Department"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Division/Section"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Current Grade Of Supervisee"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(71; "Date Of Current Designation"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Terms Of Service"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Permanent,Partime,Casual,Contract,Board member,Attachee,Intern';
            OptionMembers = Permanent, Partime, Casual, Contract, Trustee, Attachee, Intern;
        }
        field(73; "Acting Appointments"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(77; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
            //  ShowDocDim;
            end;
        }
        field(78; Initiated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(82; Manager; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(79; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=FILTER(false));

            trigger OnValidate()
            begin
            // ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(80; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=FILTER(false));

            trigger OnValidate()
            begin
            //    ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(87; "Period Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(90; HOD; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Target No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Target No" = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Target Nos");
            NoSeriesMgt.InitSeries(HRSetup."Target Nos", xRec."No. series", 0D, "Target No", "No. series");
        end;
        Date:=Today;
        "Appraisee ID":=UserSetup."User ID";
        if UserSetup.Get(UserSetup."User ID")then begin
            if Employee.Get(UserSetup."Employee No.")then begin
                //Check if the Appraisal for period has been set 
                EmpAppraisal.Reset;
                EmpAppraisal.SetRange("Employee No", UserSetup."Employee No.");
                EmpAppraisal.SetRange("Appraisal Period", "Appraisal Period");
                if EmpAppraisal.Find('-')then Error(Error001, "Employee No", "Appraisal Period");
                //Insert Appraisee Details 
                "Employee No":=Employee."No.";
                "Appraisee ID":=Employee."User ID";
                "Appraisee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                "Appraisee's Job Title":=Employee."Job Position Title";
                "Job Group":=Employee."Salary Scale";
                //"Shortcut Dimension 1 Code" := Employee."Global Dimension 1 Code";
                //"Shortcut Dimension 2 Code" := Employee."Global Dimension 2 Code";
                "Date Of Current Designation":=Employee."Employment Date";
                "Acting Appointments":=Employee."Acting Position";
                "Terms Of Service":=Employee."Employment Type";
                "Division/Section":=Employee."Division/Section";
                Directorate:=Employee.Directorate;
                Manager:=Employee.Manager;
                //Get Appraiser Details
                if UserSetup.Get(UserSetup."Approver ID")then begin
                    if Employee.Get(UserSetup."Employee No.")then begin
                        "Appraiser No":=Employee."No.";
                        "Appraiser ID":=Employee."User ID";
                        "Appraisers Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                        "Appraiser's Job Title":=Employee."Job Title";
                    end;
                end;
            end;
            if UserSetup.Manager then HOD:=true;
        end;
    end;
    // procedure ShowDocDim()
    // var
    //     OldDimSetID: Integer;
    // begin
    //     OldDimSetID := "Dimension Set ID";
    //     "Dimension Set ID" :=
    //       DimMgt.EditDimensionSet(
    //         "Dimension Set ID", StrSubstNo('%1 %2', "Appraisal Period", "Target No"),
    //       //  "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    //     if OldDimSetID <> "Dimension Set ID" then begin
    //         Modify;
    //     end;
    // end;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if "Target No" <> '' then Modify;
    end;
    var Employee: Record Employee;
    HRSetup: Record "Human Resources Setup";
    UserSetup: Record "User Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    EmpAppraisal: Record "Target Setup Header";
    Error001: Label 'You have already created an appraisal for %1 %2';
    AppraisalFormat: Record "Appraisal Formats";
    AppraisalPeriods: Record "Appraisal Periods";
    Matrix: Record "Perfomance rating matrix";
    DimMgt: Codeunit DimensionManagement;
}
