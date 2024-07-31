table 50506 "Risk Header"
{
    fields
    {
        field(1; "No."; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF "No." <> '' THEN NoSeriesMgt.TestManual(RiskSetup."Risk Nos.");
            end;
        }
        field(2; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employee No."; Code[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                IF Employee.GET("Employee No.")THEN BEGIN
                    "Shortcut Dimension 1 Code":=Employee."Global Dimension 1 Code";
                    "Shortcut Dimension 2 Code":=Employee."Global Dimension 2 Code";
                END;
            end;
        }
        field(5; "Employee Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Risk Description"; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Memo;
        }
        field(7; "Document Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,HOD,Board Review,MD,Auditor,Closed,Project Manager,Resolved';
            OptionMembers = New, HOD, "Board Review", MD, Closed, Auditor, "Project Manager", Resolved;
        }
        field(8; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Date Identified"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Risk Category"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories";

            trigger OnValidate()
            begin
                RiskCategory.Reset();
                RiskCategory.SetRange(Code, "Risk Category");
                IF RiskCategory.FindFirst()THEN "Risk Category Description":=RiskCategory.Description;
            end;
        }
        field(11; "Risk Category Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Value at Risk"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;

            trigger OnValidate()
            begin
            // RiskImpact.Reset();
            // RiskImpact.SetFilter("Financial start", '<=%1', "Value at Risk");
            // RiskImpact.SetFilter("Financial End", '>=%1', "Value at Risk");
            // IF RiskImpact.FindFirst() then begin
            //     "Risk Impact" := RiskImpact.Code;
            //     "Risk Impact Value" := RiskImpact."Impact Score";
            //     Validate("Risk Impact Value");
            //     Validate("Risk Impact");
            //     Validate("Risk (L * I)");
            //     Validate("Residual Value");
            //     "Residual Value" := "Value at Risk" - "Value after Control";
            //     IF "Residual Value" < 1 THEN
            //         "Residual Value" := 0;
            // end;
            end;
        }
        field(13; "Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
            InitValue = '';

            trigger OnValidate()
            begin
            // IF RiskLikelihood.GET("Risk Likelihood") THEN
            //     "Risk Likelihood Value" := RiskLikelihood."Likelihood Score";
            // VALIDATE("Risk Likelihood Value");
            end;
        }
        field(14; "Risk Impact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            InitValue = '';

            trigger OnValidate()
            begin
            // IF RiskImpact.GET("Risk Impact") THEN
            //     "Risk Impact Value" := RiskImpact."Impact Score";
            // VALIDATE("Risk Impact Value");
            // "Residual Likelihood Impact" := ("Risk Impact Value" - "Control Evaluation Impact");
            // IF "Residual Likelihood Impact" < 1 THEN
            //     "Residual Likelihood Impact" := 1;
            end;
        }
        field(15; "Risk Likelihood Value"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;

            trigger OnValidate()
            begin
                if("Risk Impact Value" <> 0) and ("Risk Likelihood Value" <> 0)then begin
                    "Risk (L * I)":=("Risk Likelihood Value" * "Risk Impact Value");
                    if "Control Evaluation Likelihood" <> 0 then "Residual Risk Likelihood":=("Risk Likelihood Value" - "Control Evaluation Likelihood");
                    IF "Residual Risk Likelihood" < 1 THEN "Residual Risk Likelihood":=1;
                    Validate("Risk (L * I)");
                end;
            end;
        }
        field(16; "Risk Impact Value"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if("Risk Impact Value" <> 0) and ("Risk Likelihood Value" <> 0)then begin
                    "Risk (L * I)":=("Risk Likelihood Value" * "Risk Impact Value");
                    "Residual Risk Likelihood":=("Risk Likelihood Value" - "Control Evaluation Likelihood");
                    IF "Risk (L * I)" < 1 THEN "Risk (L * I)":=1;
                    Validate("Risk (L * I)");
                end;
            end;
        }
        field(17; "Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                RAGSetup.Reset();
                RAGSetup.SetFilter("Gross Risk start", '<=%1', "Risk (L * I)");
                RAGSetup.SetFilter("Gross Risk end", '>=%1', "Risk (L * I)");
                IF RAGSetup.FindFirst()then begin
                    "RAG Status":=RAGSetup.Option;
                end;
            end;
        }
        field(18; "Control Evaluation Likelihood"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Control Risk (L * I)":=("Control Evaluation Impact" * "Control Evaluation Likelihood");
                "Residual Risk Likelihood":=("Risk Likelihood Value" - "Control Evaluation Likelihood");
                IF "Residual Risk Likelihood" < 1 THEN "Residual Risk Likelihood":=1;
                VALIDATE("Residual Risk Likelihood");
            end;
        }
        field(19; "Control Evaluation Impact"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Control Risk (L * I)":=("Control Evaluation Impact" * "Control Evaluation Likelihood");
                IF "Control Risk (L * I)" < 1 THEN "Control Risk (L * I)":=1;
                "Residual Likelihood Impact":=("Risk Impact Value" - "Control Evaluation Impact");
                IF "Residual Likelihood Impact" < 1 THEN "Residual Likelihood Impact":=1;
            end;
        }
        field(20; "Residual Risk Likelihood"; Decimal)
        {
            Caption = 'Residual Risk Likelihood Value';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                // RiskLikelihood.Reset();
                // RiskLikelihood.SetRange("Likelihood Score", "Residual Risk Likelihood");
                // IF RiskLikelihood.FindFirst() then begin
                //     "Residual Risk Likelihood Cat" := RiskLikelihood.Code;
                // end;
                "Residual Risk (L * I)":=("Residual Likelihood Impact" * "Residual Risk Likelihood");
                IF "Residual Risk (L * I)" < 1 THEN "Residual Risk (L * I)":=1;
                Validate("Residual Risk (L * I)");
            end;
        }
        field(21; "Residual Likelihood Impact"; Decimal)
        {
            Caption = 'Residual Risk Impact Value';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Residual Risk (L * I)":=("Residual Likelihood Impact" * "Residual Risk Likelihood");
                IF "Residual Risk (L * I)" < 1 THEN "Residual Risk (L * I)":=1;
                Validate("Residual Risk (L * I)");
                IF RiskLikelihood.GET("Residual Likelihood Impact")THEN "Residual Risk Impact":=RiskLikelihood.Code;
            end;
        }
        field(22; "Residual Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                RAGSetup.Reset();
                RAGSetup.SetFilter("Gross Risk start", '<=%1', "Residual Risk (L * I)");
                RAGSetup.SetFilter("Gross Risk end", '>=%1', "Residual Risk (L * I)");
                IF RAGSetup.FindFirst()then begin
                    "Residual RAG Status":=RAGSetup.Option;
                end;
            end;
        }
        field(23; "Risk Response"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Accept,Transfer,Mitigate,Avoid';
            OptionMembers = " ", Accept, Transfer, Mitigate, Avoid;
        }
        field(24; "Shortcut Dimension 1 Code"; Code[50])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), "Dimension Value Type"=filter(Standard));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(25; "Shortcut Dimension 2 Code"; Code[50])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(26; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Pending Approval,Released';
            OptionMembers = New, "Pending Approval", Released;
        }
        field(27; Type; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Risk,Risk Opportunity';
            OptionMembers = " ", Risk, "Risk Opportunity";
        }
        field(28; "Risk Opportunity Assessment"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Enhance,Exploit,Share,Do Nothing';
            OptionMembers = " ", Enhance, Exploit, Share, "Do Nothing";
        }
        field(29; "Risk Department"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE("Global Dimension No.", 1);
                DimVal.SETRANGE(Code, "Risk Department");
                IF DimVal.FINDFIRST THEN "Risk Department Description":=DimVal.Name;
                GetChampionUserID;
            end;
        }
        field(30; "Risk Department Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "HOD User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Risk Region"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                DimVal.RESET;
                DimVal.SETRANGE("Global Dimension No.", 2);
                DimVal.SETRANGE(Code, "Risk Region");
                IF DimVal.FINDFIRST THEN "Risk Region Name":=DimVal.Name;
                GetChampionUserID;
            end;
        }
        field(33; "Risk Region Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Project Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Review Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Assessment Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Linked Incident"; Code[50])
        {
            TableRelation = "User Support Incident";
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                UserSupp: Record "User Support Incident";
            begin
                IF UserSupp.GET(Rec."Linked Incident")THEN BEGIN
                    "Linked Incident Description":=UserSupp."Incident Description";
                END;
            end;
        }
        field(38; "Rejection Reason"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Mark Okay"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Linked Incident Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Risk Probability"; Decimal)
        {
            DataClassification = ToBeClassified;
        //InitValue = 0;
        // trigger OnValidate()
        // begin
        //     if ("Risk Probability" < 0) or ("Risk Probability" > 100) then Error(ValueError);
        //     RiskLikelihood.Reset();
        //     RiskLikelihood.SetFilter("Probability Start Range", '<=%1', "Risk Probability");
        //     RiskLikelihood.SetFilter(Probability, '>=%1', "Risk Probability");
        //     IF RiskLikelihood.FindFirst() then begin
        //         "Risk Likelihood" := RiskLikelihood.Code;
        //         "Risk Likelihood Value" := RiskLikelihood."Likelihood Score";
        //         Validate("Risk Likelihood Value");
        //         Validate("Risk Impact Value");
        //         Validate("Residual Likelihood Impact");
        //     end;
        // end;
        }
        field(42; "RAG Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "VERY HIGH", HIGH, AMBER, LOW;
            OptionCaption = ' ,VERY HIGH,HIGH,AMBER,GREEN';
        }
        field(43; "Value after Control"; Decimal)
        {
            DataClassification = ToBeClassified;
            InitValue = 0;

            trigger OnValidate()
            begin
                // RiskImpact.Reset();
                // RiskImpact.SetFilter("Financial start", '<=%1', "Value after Control");
                // RiskImpact.SetFilter("Financial End", '>=%1', "Value after Control");
                // IF RiskImpact.FindFirst() then begin
                //     "Control Evaluation Impact" := RiskImpact."Impact Score";
                //     "Control Risk Impact" := RiskImpact.Code;
                //     Validate("Control Evaluation Impact");
                //     Validate("Control Risk Impact");
                //     Validate("Control Evaluation Likelihood");
                //     Validate("Control Risk (L * I)");
                //     Validate("Residual Value");
                "Residual Value":="Value at Risk" - "Value after Control";
                IF "Residual Value" < 1 THEN "Residual Value":=0;
            end;
        }
        field(44; "Control Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
            InitValue = '';

            trigger OnValidate()
            begin
                // IF RiskLikelihood.GET("Control Risk Likelihood") THEN
                //     "Control Evaluation Likelihood" := RiskLikelihood."Likelihood Score";
                VALIDATE("Control Evaluation Likelihood");
            end;
        }
        field(45; "Control Risk Impact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            InitValue = '';

            trigger OnValidate()
            begin
                // IF RiskImpact.GET("Control Risk Impact") THEN
                //     "Control Evaluation Impact" := RiskImpact."Impact Score";
                VALIDATE("Control Evaluation Impact");
            //"Residual Likelihood Impact" := ("Risk Impact Value" - "Control Evaluation Impact");
            // IF "Residual Likelihood Impact" < 1 THEN
            //     "Residual Likelihood Impact" := 1;
            end;
        }
        field(46; "Control Risk (L * I)"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                RAGSetup.Reset();
                RAGSetup.SetFilter("Gross Risk start", '<=%1', "Control Risk (L * I)");
                RAGSetup.SetFilter("Gross Risk end", '>=%1', "Control Risk (L * I)");
                IF RAGSetup.FindFirst()then begin
                    "Control RAG Status":=RAGSetup.Option;
                end;
            end;
        }
        field(47; "Control RAG Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "VERY HIGH", HIGH, AMBER, LOW;
            OptionCaption = 'VERY HIGH,HIGH,AMBER,LOW';
        }
        field(48; "Control Risk Probability"; Decimal)
        {
        // DataClassification = ToBeClassified;
        // InitValue = 0;
        // trigger OnValidate()
        // begin
        //     if ("Control Risk Probability" < 0) or ("Control Risk Probability" > 100) then Error(ValueError);
        //     RiskLikelihood.Reset();
        //     RiskLikelihood.SetFilter("Probability Start Range", '<=%1', "Control Risk Probability");
        //     RiskLikelihood.SetFilter(Probability, '>=%1', "Control Risk Probability");
        //     IF RiskLikelihood.FindFirst() then begin
        //         "Control Risk Likelihood" := RiskLikelihood.Code;
        //         "Control Evaluation Likelihood" := RiskLikelihood."Likelihood Score";
        //         Validate("Control Evaluation Likelihood");
        //         Validate("Control Evaluation Impact");
        //         Validate("Control Risk (L * I)");
        //         Validate("Residual Risk Likelihood");
        //     end;
        // end;
        }
        field(49; "Residual RAG Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "VERY HIGH", HIGH, AMBER, LOW;
            OptionCaption = 'VERY HIGH,HIGH,AMBER,GREEN';
        }
        field(50; "Residual Value"; Decimal)
        {
            DataClassification = ToBeClassified;
        // InitValue = 0;
        // trigger OnValidate()
        // begin
        //     RiskImpact.Reset();
        //     RiskImpact.SetFilter("Financial start", '<=%1', "Residual Value");
        //     RiskImpact.SetFilter("Financial End", '>=%1', "Residual Value");
        //     IF RiskImpact.FindFirst() then begin
        //         "Residual Likelihood Impact" := RiskImpact."Impact Score";
        //         "Residual Risk Impact" := RiskImpact.Code;
        //         Validate("Residual Likelihood Impact");
        //         Validate("Residual Risk Likelihood");
        //         Validate("Residual Risk (L * I)");
        //         "Residual Value" := "Value at Risk" - "Value after Control";
        //         IF "Residual Value" < 1 THEN
        //             "Residual Value" := 0;
        //     end;
        // end;
        }
        field(51; "Risk Description2"; Text[100])
        {
            //ObsoleteState = Removed;
            DataClassification = ToBeClassified;
        }
        field(52; "Additional mitigation controls"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Risk Acceptance Decision"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", Treat, Tolerate, Terminate, Transfer;
            OptionCaption = ' ,Treat,Tolerate,Terminate,Transfer';
        }
        field(54; "Residual Risk Likelihood Cat"; Code[20])
        {
            Caption = 'Residual Risk Likelihood';
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
            InitValue = '';
        }
        field(55; "Residual Risk Impact"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            InitValue = '';
        }
        field(56; "Root Cause Analysis"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(57; "Mitigation Suggestions"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(58; "Existing Risk Controls"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Memo;
        }
        field(59; "Board Recommendation"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Risk Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Annual Risk Setup";

            trigger OnValidate()
            var
                RiskSetup: Record "Annual Risk Setup";
            begin
                RiskSetup.Reset();
                RiskSetup.SetRange(Code, "Risk Code");
                if RiskSetup.FindFirst()then begin
                    "Description":=RiskSetup.Description;
                    "Value at Risk":=RiskSetup."Value At risk";
                    "Risk Likelihood":=RiskSetup."Likelihood code";
                    "Risk Probability":=RiskSetup.Probability;
                    "Risk Likelihood Value":=RiskSetup."Likelihood Score";
                    "Risk Impact Value":=RiskSetup."Impact Score";
                    "Risk Impact":=RiskSetup."Impact code";
                    "Value after Control":=RiskSetup."Value After Control";
                    validate("Value after Control");
                    "Control Evaluation Impact":=RiskSetup."Control Impact Score";
                    "Control Risk Impact":=RiskSetup."Control Impact code";
                    "Control Evaluation Likelihood":=RiskSetup."Control Likelihood Score";
                    "Control Risk Likelihood":=RiskSetup."Control Likelihood code";
                    "Control Risk Probability":=RiskSetup."Control Probability";
                    Validate("Risk Impact Value");
                    Validate("Risk Likelihood Value");
                    Validate("Value after Control");
                    validate("Control Evaluation Likelihood");
                    validate("Control Evaluation Impact");
                    validate("Residual Risk Likelihood");
                end;
            end;
        }
        field(61; Description; Code[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Responsible Officer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                Emp: Record Employee;
            begin
                if Emp.get("Responsible Officer No.")then "Responsible Officer Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            end;
        }
        field(63; "Responsible Officer Name"; Text[100])
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
    }
    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Risk Description")
        {
        }
    }
    trigger OnInsert()
    begin
        if not RiskSetup.Get()then begin
            RiskSetup.Init();
            RiskSetup.Insert();
        end;
        RiskSetup.TESTFIELD("Risk Nos.");
        NoSeriesMgt.InitSeries(RiskSetup."Risk Nos.", xRec."No. Series", TODAY, "No.", "No. Series");
        "Created By":=USERID;
        "Date Created":=TODAY;
        IF UserSetup.GET(USERID)THEN BEGIN
            UserSetup.TESTFIELD("Employee No.");
            IF Employee.GET(UserSetup."Employee No.")THEN BEGIN
                "Employee No.":=Employee."No.";
                "Employee Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                VALIDATE("Employee No.");
            END;
        END;
    end;
    var RiskSetup: Record "Audit Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Employee: Record Employee;
    RiskCategory: Record "Risk Categories";
    RiskImpact: Record "Risk Impacts";
    RiskLikelihood: Record "Risk Likelihood";
    DimMgt: Codeunit DimensionManagement;
    DimVal: Record "Dimension Value";
    RAGSetup: Record "Risk RAG Status";
    ValueError: Label 'Probability should be between 0 and 100';
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(DATABASE::Employee, "No.", FieldNumber, ShortcutDimCode);
        MODIFY;
    end;
    local procedure GetChampionUserID()
    var
        RiskChampion: Record "Internal Audit Champions";
    begin
        RiskChampion.Reset();
        RiskChampion.SetRange("Shortcut Dimension 1 Code", "Risk Region");
        if RiskChampion.FindFirst()then "HOD User ID":=RiskChampion."User ID";
    end;
}
