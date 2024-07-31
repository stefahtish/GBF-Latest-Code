table 50430 "Prospective Suppliers"
{
    fields
    {
        field(1; "Ref No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request";
        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(3; "Physical Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Postal Address"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(5; City; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "E-mail"; Text[50])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                MailMgt.CheckValidEmailAddress("E-mail");
            end;
        }
        field(7; "Telephone No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Mobile No"; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "KBA Bank Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Banks;

            trigger OnValidate()
            var
                Banks: Record Banks;
            begin
                Banks.Reset();
                If Banks.Get("KBA Bank Code")then "Bank Name":=Banks.Name;
            end;
        }
        field(11; "KBA Branch Code"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Bank Branches"."Branch Code" where("Bank Code"=field("KBA Bank Code"));

            trigger OnValidate()
            var
                BankBranches: Record "Bank Branches";
            begin
                BankBranches.Reset();
                BankBranches.SetRange("Branch Code", "KBA Branch Code");
                If BankBranches.FindFirst()then "Bank Branch Name":=BankBranches."Branch Name";
            end;
        }
        field(12; "Bank account No"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(13; Category; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Supplier Category";

            trigger OnValidate()
            var
                Cat: Record "Supplier Category";
            begin
                if Cat.get(Category)then "Category Name":=cat.Description;
            end;
        }
        field(14; "Fiscal Year"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(15; Selected; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Pre Qualified"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Fax No"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Category Name"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Registration No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Vendor No"; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Vendor No")then begin
                    Name:=Vendor.Name;
                    "Physical Address":=Vendor.Address;
                    "Postal Address":=Vendor.Address;
                    City:=Vendor.City;
                    "E-mail":=Vendor."E-Mail";
                    "Telephone No":=Vendor."Phone No.";
                    "Fax No":=Vendor."Fax No.";
                    "Fax No.":=Vendor."Fax No.";
                    "Country/Region Code":=Vendor."Country/Region Code";
                    "Post Code":=Vendor."Post Code";
                end;
            end;
        }
        field(22; "Vendor Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "  ", Medical, Law;
        }
        field(23; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Released,Pending Approval,Pending Prepayment,Rejected,Approved,Closed';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected, Approved, Closed;
        }
        field(24; Attachment; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(25; "Fax No."; Text[30])
        {
            Caption = 'Fax No.';
            DataClassification = ToBeClassified;
        }
        field(26; "Post Code"; Code[20])
        {
            Caption = 'Post Code';
            DataClassification = ToBeClassified;
            TableRelation = IF("Country/Region Code"=CONST(''))"Post Code"
            ELSE IF("Country/Region Code"=FILTER(<>''))"Post Code" WHERE("Country/Region Code"=FIELD("Country/Region Code"));
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;

            trigger OnValidate()
            begin
                PostCode.ValidatePostCode(City, "Post Code", County, "Country/Region Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(27; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            DataClassification = ToBeClassified;
            TableRelation = "Country/Region";

            trigger OnValidate()
            begin
                PostCode.ValidateCountryCode(City, "Post Code", County, "Country/Region Code");
                if "Country/Region Code" <> xRec."Country/Region Code" then;
            //  VATRegistrationValidation;
            end;
        }
        field(28; County; Text[30])
        {
            Caption = 'County';
            DataClassification = ToBeClassified;
        }
        field(29; "Sub County"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Contract Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Contract Period"; DateFormula)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Contract Start Date" <> 0D then "Contract End Date":=CalcDate("Contract Period", "Contract Start Date");
            end;
        }
        field(32; "Contract End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(33; "No."; Code[20])
        {
        }
        field(34; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Project Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Prospective; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(37; Score; Decimal)
        {
            CalcFormula = sum("Supplier Evaluation Line".Score where(Supplier=field("No."), "Quote No"=field("Project Code")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(38; Date; Date)
        {
        }
        field(39; "Company PIN No."; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*Vendor.reset;
                Vendor.SetRange("KRA PIN", "Company PIN No.");
                if Vendor.FindFirst then
                    Error('Vendor with PIN %1 already exists');*/
            //Get Similar KRA PIN
            /*ProspectiveRec.Reset();
                ProspectiveRec.SetRange(ProspectiveRec."Company PIN No.", "Company PIN No.");
                if ProspectiveRec.FindFirst then
                    TransferFields(ProspectiveRec, false);*/
            end;
        }
        field(40; Title;enum Salutations)
        {
        }
        field(41; "Organization Type";enum OrganizationTypes)
        {
        }
        field(42; "Bank Account Type";enum SupplierBankAccountTypes)
        {
        }
        field(43; "Supplier Types";enum SupplierTypes)
        {
        }
        field(44; "Company Reg No."; Code[50])
        {
            Caption = 'Company Registration No.';
        }
        field(45; "Contact Person Name"; Text[100])
        {
        }
        field(46; "Job Title"; Text[100])
        {
        }
        field(47; "Contact Phone No."; Code[20])
        {
        }
        field(48; "Contact E-Mail Address"; Text[100])
        {
            trigger OnValidate()
            begin
                MailMgt.CheckValidEmailAddress("Contact E-Mail Address");
            end;
        }
        field(49; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(50; "PIN Certificate Expiry"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "Tender No."; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Procurement Request" where("Process Type"=const(Tender), "Tender Type"=const(Open));

            trigger OnValidate()
            begin
                if TenderRec.Get("Tender No.")then begin
                    TenderLine.Reset();
                    TenderLine.SetRange(TenderLine."Requisition No", TenderRec."No.");
                    if TenderLine.FindFirst then begin
                        repeat ProspectiveSupplierLine.Init;
                            ProspectiveSupplierLine."Response No":="No.";
                            ProspectiveSupplierLine."Line No":=TenderLine."Line No";
                            ProspectiveSupplierLine.Type:=TenderLine.Type;
                            ProspectiveSupplierLine.No:=TenderLine."No";
                            ProspectiveSupplierLine.Description:=TenderLine.Description;
                            ProspectiveSupplierLine.Quantity:=TenderLine.Quantity;
                            ProspectiveSupplierLine."Unit of Measure":=TenderLine."Unit of Measure";
                            ProspectiveSupplierLine."Procurement Plan":=TenderLine."Procurement Plan";
                            ProspectiveSupplierLine."Procurement Plan Item":=TenderLine."Procurement Plan Item";
                            ProspectiveSupplierLine."Budget Line":=TenderLine."Budget Line";
                            ProspectiveSupplierLine."Shortcut Dimension 1 Code":=TenderLine."Shortcut Dimension 1 Code";
                            ProspectiveSupplierLine.Validate("Shortcut Dimension 1 Code");
                            ProspectiveSupplierLine."Shortcut Dimension 2 Code":=TenderLine."Shortcut Dimension 2 Code";
                            ProspectiveSupplierLine.Validate("Shortcut Dimension 2 Code");
                            ProspectiveSupplierLine."Request Date":=TenderRec.TenderOpeningDate;
                            ProspectiveSupplierLine."Expected Receipt Date":=DT2Date(TenderRec.TenderClosingDate);
                            ProspectiveSupplierLine.Committed:=TenderLine.Committed;
                            ProspectiveSupplierLine.Specification2:=TenderLine.Specification2;
                            ProspectiveSupplierLine."VAT Prod. Posting Group":=TenderLine."VAT Prod. Posting Group";
                            ProspectiveSupplierLine."VAT %":=TenderLine."VAT %";
                            ProspectiveSupplierLine."Amount Inclusive VAT":=TenderLine."Amount Inclusive VAT";
                            if not ProspectiveSupplierLine.Get(ProspectiveSupplierLine."Response No", ProspectiveSupplierLine."Line No")then ProspectiveSupplierLine.Insert(true);
                        until TenderLine.Next = 0;
                    end;
                end;
            end;
        }
        field(52; "Supplier Status";enum "Supplier Status")
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Committee Code"; code[50])
        {
        }
        field(54; "Tenders Applied"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Prospective Supplier Tender" where("Prospect No."=field("No.")));
            Editable = false;
        }
        field(55; "Type"; Option)
        {
            OptionMembers = Tender, RFQ, RFP, EOI;
            DataClassification = ToBeClassified;
        }
        field(56; "Certificate of incorporation"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Tax Compliance Certificate"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(58; Road; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(59; Building; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(60; Street; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Plot No"; Code[100])
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Type of Supplier"; Code[50])
        {
            TableRelation = "Supplier Type";
            DataClassification = ToBeClassified;
        }
        field(63; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(64; "Bank Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(65; "Bank Branch Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(66; "Vendor Created"; Boolean)
        {
            Editable = false;
            DataClassification = ToBeClassified;
        }
        field(67; "Agpo Group"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", PWD, Women, Youth;
        }
        field(68; "Agpo Number"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(69; "Supplier Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ", General, AGPO;
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
        fieldgroup(DropDown; "No.", Name)
        {
        }
    }
    trigger OnInsert()
    begin
        PurchSetup.Get;
        if "No." = '' then begin
            PurchSetup.TestField("Prospective Suppliers Nos");
            NoSeriesMgt.InitSeries(PurchSetup."Prospective Suppliers Nos", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        Date:=Today;
    end;
    var PurchSetup: Record "Purchases & Payables Setup";
    Vendor: Record Vendor;
    PostCode: Record "Post Code";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    SupEvaLine: Record "Supplier Evaluation Line";
    TenderRec: Record "Procurement Request";
    TenderLine: Record "Procurement Request Lines";
    ProspectiveSupplierLine: Record "Prospective Supplier Line";
    MailMgt: Codeunit "Mail Management";
    ProspectiveRec: Record "Prospective Suppliers";
    procedure CreateVend(var Prequalifiedlist: Record "Prequalified Suppliers")
    var
        Vend: Record Vendor;
        CategoryRec: Record "Supplier Category";
    begin
        Prequalifiedlist.TestField(Prequalifiedlist."Company PIN No");
        Vend.SetCurrentKey("KRA PIN");
        Vend.SetRange(Vend."KRA PIN", Prequalifiedlist."Company PIN No");
        if Vend.FindFirst then Error('The Vendor %1 PIN No %2 already exists in the system', Vend.Name, Vend."KRA PIN");
        Vend.Init;
        Vend."No.":='';
        Vend.Name:=Prequalifiedlist.Name;
        Vend.Address:=Prequalifiedlist."Physical Address";
        Vend."Address 2":=Prequalifiedlist."Postal Address";
        Vend."E-Mail":=Prequalifiedlist."E-mail";
        Vend."Phone No.":=Prequalifiedlist."Telephone No";
        Vend."Telex No.":=Prequalifiedlist."Mobile No";
        Vend.Contact:=Prequalifiedlist."Contact Person";
        //Vend."KBA Code":=Prequalifiedlist."KBA Bank Code";
        //Vend."KBA Branch Code":=Prequalifiedlist."KBA Branch Code";
        Vend."Our Account No.":=Prequalifiedlist."Bank account No";
        //Vend."Vendor Type":=Prequalifiedlist."Vendor Type";
        Vend."KRA PIN":=Prequalifiedlist."Company PIN No";
        //Vend.v:=Prequalifiedlist."Registration No";
        if CategoryRec.Get(Prequalifiedlist.Category)then begin
            Vend."Gen. Bus. Posting Group":=CategoryRec."Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group":=CategoryRec."VAT Bus. Posting Group";
            Vend."Vendor Posting Group":=CategoryRec."Vendor Posting Group";
        end;
        Vend.Insert(true);
        Prequalifiedlist."Vendor No":=Vend."No.";
        Prequalifiedlist.Modify;
    end;
    procedure CreateVendr(var Prequalifiedlist: Record "Prospective Suppliers"): Code[50]var
        Vend: Record Vendor;
        CategoryRec: Record "Supplier Category";
        PSetup: Record "Purchases & Payables Setup";
        Preq: Record "Prequalified Suppliers";
    begin
        PSetup.get;
        PSetup.TestField("Def Gen. Bus. Posting Group");
        PSetup.TestField("Default Vendor Posting Group");
        Prequalifiedlist.TestField("Company PIN No.");
        Vend.Reset();
        Vend.SetRange("KRA PIN", Prequalifiedlist."Company PIN No.");
        if Vend.FindFirst then exit(Vend."No.")
        else
        begin
            Vend.Init;
            Vend."No.":='';
            Vend.Name:=Prequalifiedlist.Name;
            Vend.Address:=Prequalifiedlist."Physical Address";
            Vend."Address 2":=Prequalifiedlist."Postal Address";
            Vend."E-Mail":=Prequalifiedlist."E-mail";
            Vend."Phone No.":=Prequalifiedlist."Telephone No";
            Vend."Telex No.":=Prequalifiedlist."Mobile No";
            Vend.Contact:=Prequalifiedlist."Contact Person Name";
            Vend."Country/Region Code":=Prequalifiedlist."Country/Region Code";
            Vend."Post Code":=Prequalifiedlist."Post Code";
            Vend."Fax No.":=Prequalifiedlist."Fax No";
            //Vend."KBA Code":=Prequalifiedlist."KBA Bank Code";
            //Vend."KBA Branch Code":=Prequalifiedlist."KBA Branch Code";
            Vend."Our Account No.":=Prequalifiedlist."Bank account No";
            //Vend."Vendor Type":=Prequalifiedlist."Vendor Type";
            Vend."KRA PIN":=Prequalifiedlist."Company PIN No.";
            //Vend.v:=Prequalifiedlist."Registration No";
            Vend."Vendor Posting Group":=PSetup."Default Vendor Posting Group";
            Vend."Gen. Bus. Posting Group":=PSetup."Def Gen. Bus. Posting Group";
            Vend."VAT Bus. Posting Group":=PSetup."Def VAT Bus. Posting Group";
            /*if CategoryRec.Get(Prequalifiedlist.Category) then begin
                Vend."Gen. Bus. Posting Group" := CategoryRec."Gen. Bus. Posting Group";
                Vend."VAT Bus. Posting Group" := CategoryRec."VAT Bus. Posting Group";
                Vend."Vendor Posting Group" := CategoryRec."Vendor Posting Group";
            end;*/
            Vend."PIN Certificate Expiry":=Prequalifiedlist."PIN Certificate Expiry";
            Vend."Company PIN No.":=Prequalifiedlist."Company PIN No.";
            Vend."KBA Bank Code":=Prequalifiedlist."KBA Bank Code";
            Vend."Bank Name":=Prequalifiedlist."Bank Name";
            Vend."KBA Branch Code":=Prequalifiedlist."KBA Branch Code";
            Vend."Bank Branch Name":=Prequalifiedlist."Bank Branch Name";
            Vend."Bank account No":=Prequalifiedlist."Bank account No";
            Vend.Insert(true);
            Prequalifiedlist."Vendor No":=Vend."No.";
            Message(Vend."No.");
            Prequalifiedlist.Modify;
            if Prequalifiedlist."Pre Qualified" = true then begin
                Preq.Init();
                Preq."Vendor No":=Vend."No.";
                Preq.Validate("Vendor No");
                if not Preq.Get("Vendor No")then Preq.Insert();
            end;
            exit(Vend."No.");
        end;
    end;
    //Getting the Record ID of the table:
    procedure GetRecordID()
    var
        RecID: RecordId;
        SupplierDocs: Record "Supplier Document Links";
    begin
        if SupplierDocs.Get(Rec."No.")then RecID:=SupplierDocs."Record ID";
    end;
}
