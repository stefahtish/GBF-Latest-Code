table 50498 "Audit Lines"
{
    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Audit Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        // TableRelation = Audit;
        // trigger OnValidate()
        // begin
        //     IF Audit.GET("Audit Code") THEN BEGIN
        //         "Audit Description" := Audit.Description;
        //         "Audit Type" := Audit."Type of Audit";
        //     END;
        //     VALIDATE("Audit Type");
        // end;
        }
        field(3; "Audit Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Assessment Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,High,Moderate,Low';
            OptionMembers = " ", High, Moderate, Low;
        }
        field(5; "Audit Type"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Types";

            trigger OnValidate()
            begin
                IF AuditType.GET("Audit Type")THEN "Audit Type Description":=AuditType.Name;
            end;
        }
        field(6; "Audit Type Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Scheduled Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(9; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(10; "Scheduled End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Audit Line Type" = "Audit Line Type"::"WorkPaper Scope" then CalcFields("WP Program No.");
            end;
        }
        field(12; "Audit Line Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Objectives,Planning,Review,Post Reveiw,Scope,Auditor,WorkPaper Conclusion,WorkPaper Objectives,WorkPaper Result,Report Objectives,Report Opinion,Report Recommendation,Report Background,Report Observation,Internal Risk,External Risk,Risk Mitigation,Risk Opportunities,Audit Plan,Compliance,Report Workpapers,WorkPaper Scope, Field Work Step,Comments,Test,Queries,Data,Indicators,Budget,Findings';
            OptionMembers = " ", Objectives, Planning, Review, "Post Reveiw", Scope, Auditor, "WorkPaper Conclusion", "WorkPaper Objectives", "WorkPaper Result", "Report Objectives", "Report Opinion", "Report Recommendation", "Report Background", "Report Observation", "Internal Risk", "External Risk", "Risk Mitigation", "Risk Opportunities", "Audit Plan", Compliance, "Report Workpapers", "WorkPaper Scope", "Field work step", Comments, Test, Queries, "Sample Data Checked", Indicators, Budget, Findings;
        }
        field(13; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Done By"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(15; "WorkPlan Ref"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(16; Comment; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Comment 1"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Differences Explained"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Reports Reviewed"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Description; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Risk Rating"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Low,Medium,High';
            OptionMembers = " ", Low, Medium, High;
        }
        field(22; Reference; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Risk Implication"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(24; Criteria; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Observation/Condition"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Action Plan / Mgt Response"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Responsible Personnel"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Risk Likelihood"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Likelihood";
        }
        field(30; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Responsible Personnel Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET("Responsible Personnel Code")THEN "Responsible Personnel":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(33; "Reminder Sent"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(34; "Risk Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Categories";

            trigger OnValidate()
            begin
                IF RiskCategory.GET("Risk Category")THEN "Risk Category Description":=RiskCategory.Description;
            end;
        }
        field(35; "Risk Category Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Risk Impacts"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Risk Impacts";
            ValidateTableRelation = false;
        }
        field(37; "Risk Mitigation"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Risk Opportunities"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(39; Frequency; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Compliance Status"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; Title; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Description of Legislation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Relevant Legislation"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(44; Remarks; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(45; Auditor; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
                IF Employee.GET(Auditor)THEN BEGIN
                    "Auditor Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
                END;
            end;
        }
        field(46; "Auditor Name"; Text[60])
        {
            DataClassification = ToBeClassified;
        }
        field(47; Completed; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Scheduled Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(49; Image; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(50; Favourable; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Description 2"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Scope Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Report Workpaper No."; Code[30])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                AuditRec.RESET;
                AuditRec.SETRANGE(Type,AuditRec.Type::"Work Paper");
                AuditRec.SETRANGE("No.","Report Workpaper No.");
                IF AuditRec.FIND('-') THEN
                  BEGIN
                    AuditMgt.InsertWorkpaperObservationToAuditReport(AuditRec,"Document No.");
                  END;
                */
            end;
        }
        field(54; "Report Workpaper Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Program Scope"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "From Program No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Review Scope No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Lines"."Line No." where("Audit Line Type"=const(Objectives), "Document No."=field("Document No."));

            trigger OnValidate()
            var
                AuditLines: Record "Audit Lines";
            begin
                AuditLines.Reset();
                AuditLines.SetRange("Document No.", "Document No.");
                AuditLines.SetRange("Audit Line Type", AuditLines."Audit Line Type"::Objectives);
                AuditLines.SetRange("Line No.", "Review Scope No.");
                if AuditLines.FindFirst()then Review:=AuditLines."Description 2";
            end;
        }
        field(58; Review; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Review Scope Selected"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(60; "Scope Line No."; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Lines"."Line No." where("Audit Line Type"=filter(Scope), "Document No."=field("WP Program No."));

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                CalcFields("WP Program No.");
                AuditLines.SetRange("Document No.", "WP Program No.");
                AuditLines.SetRange("Audit Line Type", AuditLines."Audit Line Type"::Scope);
                AuditLines.SetRange("Line No.", "Scope Line No.");
                if AuditLines.Findfirst()then begin
                    AuditLines.CalcFields(Description);
                    Description:=AuditLines.Description;
                    "Description 2":=AuditLines."Description 2";
                end;
            end;
        }
        field(61; "Description 2 Blob"; BLOB)
        {
            DataClassification = ToBeClassified;
            Description = 'Provides the place to input description of an Audit Review';
        }
        field(62; "Procedure Prepared By."; Code[50])
        {
            DataClassification = ToBeClassified;
            Description = 'Specifies the Reveiw Procedure User that prepared the review.';
            Editable = false;
            TableRelation = "User Setup"."User ID";
        }
        field(63; "Review Procedure Blob"; BLOB)
        {
            DataClassification = ToBeClassified;
        }
        field(64; Rating2; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                RatioSetup.SetRange("Risk Category", "Risk Category");
                if RatioSetup.Find('-')then begin
                    if(Rating2 > RatioSetup."Max.Rating") or (Rating2 < RatioSetup."Min.Rating")then Error(RatingErr, RatioSetup."Min.Rating", RatioSetup."Max.Rating");
                end;
            end;
        }
        field(65; "Update Frequency"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Daily,Weekly,Monthly,Quaterly,Semi Annually,Annually';
            OptionMembers = " ", Daily, Weekly, Monthly, Quaterly, "Semi Annually", Annually;
        }
        field(66; "Update Stopped"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Update Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(68; Days; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(69; Phase; Code[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Review Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", "Risk based review", "Other Review", Other;
            OptionCaption = ' ,Risk based review,Other Review,Other';
        }
        field(71; FieldWork; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(72; "Report to Audit Committee"; Code[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(73; "Accept/Reject"; Option)
        {
            OptionMembers = " ", Accept, Reject;
            OptionCaption = ' ,Accept,Reject';
            DataClassification = ToBeClassified;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            DataClassification = ToBeClassified;
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
            //ShowDimensions;
            end;
            trigger OnValidate()
            begin
            //DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
            end;
        }
        field(481; "WP Program No."; Code[10])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Audit Header"."Audit Program No." where("No."=field("Document No.")));
        }
        field(482; Indicator; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(483; Target; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(484; Actual; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(485; "Q1"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(486; "Q2"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotalAmount();
            end;
        }
        field(487; "Q3"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotalAmount();
            end;
        }
        field(488; "Q4"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                Modify();
                UpdateTotalAmount();
            end;
        }
        field(489; "Total Amount"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(490; "Quarter"; Option)
        {
            OptionMembers = Q1, Q2, Q3, Q4;

            trigger OnValidate()
            var
                AuditLines: Record "Audit Lines";
            begin
                AuditLines.Reset();
                AuditLines.SetRange("Document No.", "Document No.");
                AuditLines.SetFilter("Line No.", '<>%1', "Line No.");
                AuditLines.SetRange("Audit Line Type", AuditLines."Audit Line Type"::Budget);
                AuditLines.SetRange(Quarter, Quarter);
                if AuditLines.FindFirst()then Error('Amount for quarter %1 already inserted', Quarter);
            end;
        }
        field(491; "Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(492; "Audit Frequency"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(493; "Year 1"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes, No;
        }
        field(494; "Year 2"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes, No;
        }
        field(495; "Year 3"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Yes, No;
        }
        field(496; Timeline; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(497; Recommendation; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
        field(498; Findings; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(499; "Audit Category"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit Categories";
        }
        field(500; "Audit Subcategory"; Text[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Audit SubCategories".Code where(Category=field("Audit Category"));

            trigger OnValidate()
            var
                Subcat: Record "Audit SubCategories";
            begin
                Subcat.reset;
                Subcat.SetRange(Category, "Audit Category");
                Subcat.SetRange(Code, "Audit Subcategory");
                if Subcat.FindFirst()then "Audit Subctegory description":=Subcat.Description;
            end;
        }
        field(501; "Audit Subctegory description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Document No.", "Audit Line Type", "Audit Code", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "Line No.":=GetNextLineNo();
    end;
    var Employee: Record Employee;
    Audit: Record Audit;
    AuditLines: Record "Audit Lines";
    AuditType: Record "Audit Types";
    RiskCategory: Record "Risk Categories";
    AuditRec: Record "Audit Header";
    AuditMgt: Codeunit "Internal Audit Management";
    RatioSetup: Record "Risk Ratio";
    RatingErr: Label 'Rating should be between %1 and %2';
    //DimMgt: Codeunit DimensionManagement;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    //DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;
    local procedure CalcDescriptionField(FieldID: Integer)
    begin
    end;
    procedure GetReviewScope(AuditLine: Record "Audit Lines")
    var
        ScopeList: Page "Select Scope - All";
        AuditLinesRec: Record "Audit Lines";
        AuditLineRecCopy: Record "Audit Lines";
        AuditLine2: Record "Audit Lines";
        AuditLineRecCopy2: Record "Audit Lines";
    begin
        AuditLinesRec.RESET;
        AuditLinesRec.SETRANGE("Document No.", AuditLine."Document No.");
        AuditLinesRec.SETRANGE("Audit Line Type", AuditLinesRec."Audit Line Type"::Scope);
        AuditLinesRec.SETRANGE("Review Scope Selected", FALSE);
        ScopeList.SETTABLEVIEW(AuditLinesRec);
        ScopeList.SetReview(TRUE);
        ScopeList.LOOKUPMODE(TRUE);
        IF ScopeList.RUNMODAL = ACTION::LookupOK THEN BEGIN
            AuditLineRecCopy.COPY(AuditLinesRec);
            AuditLineRecCopy.SETRANGE("Review Scope Selected", TRUE);
            IF AuditLineRecCopy.FINDSET THEN BEGIN
                REPEAT AuditLine2.INIT;
                    AuditLine2."Document No.":=AuditLineRecCopy."Document No.";
                    AuditLine2."Audit Line Type":=AuditLine2."Audit Line Type"::Review;
                    AuditLine2."Line No.":=GetNextLineNo;
                    AuditLine2."Review Scope No.":=AuditLineRecCopy."Line No.";
                    AuditLineRecCopy.CALCFIELDS(Description);
                    AuditLine2.Description:=AuditLineRecCopy.Description;
                    AuditLine2."Procedure Prepared By.":=USERID;
                    //IF NOT CheckScopeNoExists(AuditLine2."Document No.",AuditLine2."Review Scope No.") THEN
                    AuditLine2.INSERT;
                UNTIL AuditLineRecCopy.NEXT = 0;
            END;
            //Set Review Scope Selected to false
            AuditLineRecCopy2.COPY(AuditLineRecCopy);
            REPEAT AuditLineRecCopy2."Review Scope Selected":=FALSE;
                AuditLineRecCopy2.MODIFY;
            UNTIL AuditLineRecCopy2.NEXT = 0;
        END;
    end;
    local procedure GetNextLineNo(): Integer var
        AuditLine: Record "Audit Lines";
    begin
        AuditLine.RESET;
        AuditLine.SETRANGE("Document No.", "Document No.");
        AuditLine.SETRANGE("Audit Line Type", "Audit Line Type");
        IF AuditLine.FINDLAST THEN EXIT(AuditLine."Line No." + 1)
        ELSE
            EXIT(1);
    end;
    local procedure CheckScopeNoExists(DocNo: Code[50]; ScopeLineNo: Integer): Boolean var
        AuditLineRec: Record "Audit Lines";
    begin
        AuditLineRec.RESET;
        AuditLineRec.SETRANGE("Document No.", DocNo);
        AuditLineRec.SETRANGE("Audit Line Type", AuditLineRec."Audit Line Type"::Review);
        AuditLineRec.SETRANGE("Review Scope No.", ScopeLineNo);
        IF AuditLineRec.FINDFIRST THEN EXIT(TRUE)
        ELSE
            EXIT(FALSE);
    end;
    local procedure UpdateTotalAmount()
    var
        AUditLines: Record "Audit Lines";
        AnnualTarget: Decimal;
    begin
        "Total Amount":="Q1" + "Q2" + "Q3" + "Q4";
        Modify();
    end;
}
