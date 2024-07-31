table 50129 "Staff Travel Line"
{
    fields
    {
        field(1; "No."; Code[20])
        {
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "Mode of Transport"; Option)
        {
            OptionCaption = ' ,Air,Taxi,Company Car,Private Car,Bus';
            OptionMembers = " ", Air, Taxi, "Company Car", "Private Car", Bus;
        }
        field(4; "Travel Date"; Date)
        {
            trigger OnValidate()
            begin
                "Return Date":="Travel Date";
            end;
        }
        field(5; "Pick up Point"; Text[30])
        {
        }
        field(6; "Pick up Time"; Time)
        {
        }
        field(7; "Drop off Point"; Text[30])
        {
        }
        field(8; "Drop off Time"; Time)
        {
        }
        field(9; "Employee No."; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                if Emp.Get("Employee No.")then "Employee Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
            /*CreateDim(
                  DATABASE::Employee,"Employee No.");
                  ValidateShortcutDimCode(1,"Global Dimension 1 Code");
                  ValidateShortcutDimCode(2,"Global Dimension 2 Code");  */
            end;
        }
        field(10; "Employee Name"; Text[100])
        {
        }
        field(11; Departure; Code[60])
        {
        }
        field(12; Destination; Code[60])
        {
        }
        field(13; "Pick Up Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Return Date" <> 0D then Validate("Return Date");
            end;
        }
        field(14; "Drop Off Date"; Date)
        {
        }
        field(15; "Full/Half Days"; Option)
        {
            OptionCaption = ' ,Full Day,Half Day';
            OptionMembers = " ", "Full Day", "Half Day";
        }
        field(16; "No. of Days"; Integer)
        {
            trigger OnValidate()
            begin
                "Return Date":="Travel Date" + "No. of Days";
            end;
        }
        field(24; "Hotel Meal Plan"; Option)
        {
            OptionCaption = ' ,Full Boad,Half Boad,Bed and Breakfast';
            OptionMembers = " ", "Full Boad", "Half Boad", "Bed and Breakfast";
        }
        field(25; "Return Date"; Date)
        {
            trigger OnValidate()
            begin
                if "Pick Up Date" > "Return Date" then Error(Text000, FieldCaption("Return Date"), FieldCaption("Pick Up Date"));
            end;
        }
        field(26; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
            end;
        }
        field(27; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(28; "Account Type"; Option)
        {
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset';
            OptionMembers = "G/L Account", Customer, Vendor, "Bank Account", "Fixed Asset";
        }
        field(29; "Account No"; Code[20])
        {
            Editable = true;
            TableRelation = IF("Account Type"=CONST("G/L Account"))"G/L Account"
            ELSE IF("Account Type"=CONST("Fixed Asset"))"Fixed Asset"
            ELSE IF("Account Type"=CONST(Customer))Customer
            ELSE IF("Account Type"=CONST("Bank Account"))"Bank Account"
            ELSE IF("Account Type"=CONST(Vendor))Vendor;

            trigger OnValidate()
            begin
                case "Account Type" of "Account Type"::"G/L Account": begin
                    GLAccount.Get("Account No");
                    GLAccount.TestField("Direct Posting", true);
                    "Account Name":=GLAccount.Name;
                end;
                "Account Type"::Vendor: begin
                    if Vendor.Get("Account No")then;
                    "Account Name":=Vendor.Name;
                end;
                "Account Type"::Customer: begin
                    Customer.Get("Account No");
                    "Account Name":=Customer.Name;
                end;
                "Account Type"::"Bank Account": begin
                    Bank.Get("Account No");
                    "Account Name":=Bank.Name;
                end;
                "Account Type"::"Fixed Asset": begin
                    FixedAsset.Get("Account No");
                    "Account Name":=FixedAsset.Description;
                end;
                end;
                Validate(Amount);
            end;
        }
        field(30; "Account Name"; Text[100])
        {
        }
        field(31; "Estimated Cost"; Decimal)
        {
        }
        field(32; Committed; Boolean)
        {
        }
        field(33; "Return Pick Up time"; Time)
        {
        }
        field(34; "Return Drop Off time"; Time)
        {
        }
        field(35; "Return Pickup Point"; Text[30])
        {
        }
        field(36; "Return Drop  off Point"; Text[30])
        {
        }
        field(37; "Supplier Code"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin
                if Vendor.Get("Supplier Code")then "Supplier Name":=Vendor.Name;
            end;
        }
        field(38; "Supplier Name"; Text[150])
        {
        }
        field(39; Comments; Text[250])
        {
        }
        field(40; "Rate per km"; Decimal)
        {
            trigger OnValidate()
            begin
                Validate("KM Covered");
            end;
        }
        field(41; "KM Covered"; Decimal)
        {
            trigger OnValidate()
            begin
                Amount:="Rate per km" * "KM Covered";
                Validate(Amount);
            end;
        }
        field(42; Amount; Decimal)
        {
            trigger OnValidate()
            begin
                "Total price":=Amount + PUWT + STPWT;
                Tax:=0.16 * "Total price";
                "Amount Inc VAT":="Total price" + Tax;
            end;
        }
        field(43; PUWT; Decimal)
        {
            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(44; STPWT; Decimal)
        {
            trigger OnValidate()
            begin
                Validate(Amount);
            end;
        }
        field(45; Tax; Decimal)
        {
        }
        field(46; "Total price"; Decimal)
        {
        }
        field(47; "Amount Inc VAT"; Decimal)
        {
        }
        field(48; Select; Boolean)
        {
            trigger OnValidate()
            begin
                TestField(Actioned);
            end;
        }
        field(49; "Payment Status"; Option)
        {
            OptionCaption = 'Admin,Finance,Procurement,Invoiced';
            OptionMembers = Admin, Finance, Procurement, Invoiced;
        }
        field(50; Actioned; Boolean)
        {
            trigger OnValidate()
            begin
                if Header.Get("No.")then StaffMgt.SendActionEmail(Header);
            end;
        }
        field(51; Status; Option)
        {
            CalcFormula = Lookup("Staff Travel Request".Status WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
            OptionCaption = 'Open,Pending Approval,Released,Rejected';
            OptionMembers = Open, "Pending Approval", Released, Rejected;
        }
        field(52; "Cost/Budget Owner"; Option)
        {
            CalcFormula = Lookup("Staff Travel Request"."Cost/Budget Owner" WHERE("No."=FIELD("No.")));
            FieldClass = FlowField;
            OptionCaption = ' ,Official,Personal';
            OptionMembers = " ", Official, Personal;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensions;
            end;
        }
        field(481; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(3));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(3, "Shortcut Dimension 3 Code");
            end;
        }
        field(482; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(4));

            trigger OnValidate()
            begin
                ValidateShortcutDimCode(4, "Shortcut Dimension 4 Code");
            end;
        }
    }
    keys
    {
        key(Key1; "No.", "Line No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnModify()
    begin
    /*IF Header.GET("No.") THEN
         IF Header.Status<>Header.Status::Open THEN
              ERROR('The Status must be open for you to make changes in this document');
        */
    end;
    var Emp: Record Employee;
    Header: Record "Staff Travel Request";
    DimMgt: Codeunit DimensionManagement;
    GLSetup: Record "General Ledger Setup";
    GLAccount: Record "G/L Account";
    Vendor: Record Vendor;
    Customer: Record Customer;
    Bank: Record "Bank Account";
    FixedAsset: Record "Fixed Asset";
    Text000: Label 'The %1 cannot be earlier than the %2';
    StaffMgt: Codeunit "Release Staff Requsitions";
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        OldDimSetID: Integer;
        GLBudget: Record "G/L Budget Entry";
        NewDimSetID: Integer;
        StaffReq: Record "Staff Travel Request";
    begin
        OldDimSetID:="Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        if("No." <> '') and ("Line No." <> 0)then Modify;
        if(OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0))then begin
            Modify;
        //IF SalesLinesExist THEN
        //UpdateAllLineDim("Dimension Set ID",OldDimSetID);
        end;
        //Fetch Output and Ourcome from Budget
        if StaffReq.Get("No.")then;
        if FieldNumber = 5 then begin
            GLSetup.Get;
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 3 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.Find('-')then begin
                //Global Dimensions
                OldDimSetID:="Dimension Set ID";
                if StaffReq."Multi-Donor" then DimMgt.ValidateShortcutDimValues(1, "Shortcut Dimension 1 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(1, StaffReq."Global Dimension 1 Code", "Dimension Set ID");
                if(OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0))then begin
                    //IF FINDSET THEN
                    Modify;
                    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;
                OldDimSetID:="Dimension Set ID";
                if StaffReq."Multi-Donor" then DimMgt.ValidateShortcutDimValues(2, "Shortcut Dimension 2 Code", "Dimension Set ID")
                else
                    DimMgt.ValidateShortcutDimValues(2, StaffReq."Global Dimension 2 Code", "Dimension Set ID");
                if(OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0))then begin
                    //IF FINDSET THEN
                    Modify;
                    DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
                end;
                OldDimSetID:="Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(3, GLBudget."Budget Dimension 1 Code", "Dimension Set ID");
                if(OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0))then begin
                    //IF FINDSET THEN
                    Modify;
                end;
                //Dim Value 4
                OldDimSetID:="Dimension Set ID";
                DimMgt.ValidateShortcutDimValues(4, GLBudget."Budget Dimension 2 Code", "Dimension Set ID");
                if(OldDimSetID <> "Dimension Set ID") and (("No." <> '') and ("Line No." <> 0))then begin
                    //IF FINDSET THEN
                    Modify;
                end;
            end;
        end;
        //G/L Account
        if FieldNumber = 6 then begin
            GLSetup.Get;
            GLBudget.SetRange("Budget Name", GLSetup."Current Budget");
            GLBudget.SetRange("Budget Dimension 4 Code", ShortcutDimCode);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::Disbursed);
            //GLBudget.SETRANGE("Budget Type",GLBudget."Budget Type"::"Donor Approved");
            if GLBudget.Find('-')then begin
                if "Account Type" <> "Account Type"::"G/L Account" then begin
                    "Account Type":="Account Type"::"G/L Account";
                //MODIFY;
                end;
                if "Account No" <> GLBudget."G/L Account No." then begin
                    "Account No":=GLBudget."G/L Account No.";
                    Validate("Account No");
                //MODIFY;
                end;
            end;
        end;
    end;
    procedure ShowDimensions()
    begin
        "Dimension Set ID":=DimMgt.EditDimensionSet("Dimension Set ID", StrSubstNo('%1 %2 %3', "No.", "Line No."));
        //VerifyItemLineDim;
        DimMgt.UpdateGlobalDimFromDimSetID("Dimension Set ID", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code");
    end;
    procedure LookupShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        StaffReq: Record "Staff Travel Request";
    begin
    /*if StaffReq.Get("No.") then;
        if FieldNumber = 5 then
            if StaffReq."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, StaffReq."Dimension Set ID");
        if FieldNumber = 6 then
            if StaffReq."Multi-Donor" then
                DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
            else
                if "Dimension Set ID" <> 0 then
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, "Dimension Set ID")
                else
                    DimMgt.LookupDimValueCode2(FieldNumber, ShortcutDimCode, StaffReq."Dimension Set ID");
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
        ValidateShortcutDimCode(FieldNumber, ShortcutDimCode);*/
    end;
    procedure ShowShortcutDimCode(var ShortcutDimCode: array[8]of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;
}
