table 50661 "Project Header"
{
    Caption = 'Contract Header';

    fields
    {
        field(1; "No."; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Project Name"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Name';
        }
        field(3; "Project Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Estimated Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Estimated End Date"; Date)
        {
            DataClassification = ToBeClassified;
            editable = false;
        }
        field(6; "Estimated Duration"; DateFormula)
        {
            Caption = 'Duration';
            DataClassification = ToBeClassified;

            Trigger onvalidate()
            begin
                "Estimated End Date":=CalcDate("Estimated Duration", "Estimated Start Date");
            end;
        }
        field(7; "Actual Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Actual End Date" > 0D then "Actual Duration":=CreateDateTime("Actual End Date", 0T) - CreateDateTime("Actual Start Date", 0T);
            end;
        }
        field(8; "Actual End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                //TestField("Actual Start Date");
                if "Estimated End Date" < "Estimated Start Date" then Error(DateError);
                "Actual Duration":=CreateDateTime("Estimated End Date", 0T) - CreateDateTime("Estimated Start Date", 0T);
                Modify;
            end;
        }
        field(9; "Actual Duration"; Duration)
        {
            DataClassification = ToBeClassified;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, "Pending Approval", Approved, Finished, "Pending Suspension", Suspended, Rejected, Verified, "Pending Verification", "Open Extensions", "Pending Extension", "Extended Contracts", "Terminated Contracts";
            OptionCaption = 'Open,Pending Approval,Approved,Finished,Pending Suspension,Suspended,Rejected,Verified,Pending Verification,Open,Pending Approval,Extended,Terminated';

            trigger OnValidate()
            begin
            end;
        }
        field(11; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(12; "Project Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Budget';
        }
        field(13; "Contract No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Description; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tender Description';
        }
        field(16; "User ID"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = User;
        }
        field(17; "Tender No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Evaluation Header"."Quote No";

            trigger OnValidate()
            Var
                ProcRequest: record "Procurement Request";
                TenderEvalHeader: Record "Tender Evaluation Header";
                TenderEvalLines: Record "Tender Evaluation Line";
                ProsSupp: Record "Prospective Suppliers";
                Project: Record "Project Header";
            begin
                Project.Reset();
                Project.SetRange("Tender No", "Tender No");
                If Project.FindFirst()then begin
                    Error('Tender No. %1 Contract has been initiated.', Project."Tender No");
                end;
                TenderEvalheader.get("Tender no");
                "Requisition No.":=TenderEvalHeader."Requisition No";
                "project name":=TenderEvalhEADER.title;
                TenderEvalLines.setrange("Quote No", tenderEvalheader."Quote No");
                TenderEvalLines.SetRange(awarded, true);
                if TenderEvalLines.FindFirst()then begin
                    "Supplier code":=TenderEvalLines."Vendor No";
                    "Supplier Name":=TenderEvalLines."Vendor Name";
                    "Project Budget":=TenderEvallines.Amount;
                    //get company details and Contact details
                    ProsSupp.Reset();
                    ProsSupp.SetRange("No.", TenderEvalLines."Vendor No");
                    If ProsSupp.FindFirst()then begin
                        "Company PIN No.":=ProsSupp."Company PIN No.";
                        "Company Physical Address":=ProsSupp."Physical Address";
                        "Company E-mail":=ProsSupp."E-mail";
                        "Company Telephone No":=ProsSupp."Telephone No";
                        "Contact Person":=ProsSupp."Contact Person Name";
                        "Job Title":=ProsSupp."Job Title";
                        "Contact E-Mail Address":=ProsSupp."Contact E-Mail Address";
                        "Bank Code":=ProsSupp."KBA Bank Code";
                        "Branch Code":=ProsSupp."KBA Branch Code";
                        "Bank account No":=ProsSupp."Bank account No";
                        "Contact Phone No.":=ProsSupp."Contact Phone No.";
                    end;
                end;
            end;
        }
        field(18; "Requisition No."; Code[50])
        {
            DataClassification = ToBeClassified;
        // fieldclass = flowfield;
        // CalcFormula = lookup("Procurement Request"."No." where("Requisition No" = field("Requisition No.")));
        }
        field(19; "Supplier Code"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Supplier Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Company PIN No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Company Physical Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Company City"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Company E-mail"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Company Telephone No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Contact Person"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Job Title"; Text[100])
        {
        }
        field(28; "Contact E-Mail Address"; Text[100])
        {
            trigger OnValidate()
            begin
            // MailMgt.CheckValidEmailAddress("Contact E-Mail Address");
            end;
        }
        field(29; "Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;
        }
        field(30; "Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code"=field("Bank Code"));
        }
        field(31; "Bank account No"; Code[25])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Contact Phone No."; Code[20])
        {
        }
        field(33; "Extension Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, "Pending Approval", Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
        }
        field(34; "Suspension Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open, "Pending Approval", Approved;
            OptionCaption = 'Open,Pending Approval,Approved';
        }
        field(35; "Reason for Suspension"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(36; "Verified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Project Extension Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Extension duration"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "New Extended Date":=CALCDATE("Extension duration", "Project Extension Date");
            end;
        }
        field(39; "New Extended Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Terms And Conditions"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Type"; Option)
        {
            OptionMembers = "", "Running", Suspension, Extension;
            OptionCaption = 'Open,Running,Suspended,Extended';
        }
        field(42; "Commitee No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Tender Committees" where("Contract"=const(true));
        }
        field(43; "Special Conditions"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Contract Conditions"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Extension Reason"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Direct Contract"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Nature Of Contract"; Option)
        {
            OptionMembers = " ", MOU, Lease, Licenses, "Consultancy Agreement", "General Contract";
            DataClassification = ToBeClassified;
        }
        field(48; "Responsibilty Holder"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            var
                EmpRec: Record Employee;
            begin
                if "Responsibilty Holder Name" <> '' then "Responsibilty Holder Name":='';
                if EmpRec.Get("Responsibilty Holder")then "Responsibilty Holder Name":=EmpRec.FullName();
            end;
        }
        field(49; "Responsibilty Holder Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(50; Parties; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51; Stage; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Creation, Verification, Running, Suspension, Termination, Finish;
        }
        field(52; "Scope of Contract"; text[100])
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
        fieldgroup(DropDown; "No.", "Project Name", "Estimated Start Date", "Estimated End Date")
        {
        }
    }
    trigger OnInsert()
    begin
        if "No." = '' then begin
            GeneralSetUp.Get;
            GeneralSetUp.TESTFIELD("Contract Mgt Nos");
            NoSeriesManagement.InitSeries(GeneralSetUp."Contract Mgt nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        "Project Date":=Today;
        "User ID":=UserId;
    end;
    var GeneralSetUp: Record "Purchases & Payables Setup";
    NoSeriesManagement: Codeunit NoSeriesManagement;
    DateError: Label 'End Date can not come before Start Date';
    ProjectDuration: DateTime;
}
