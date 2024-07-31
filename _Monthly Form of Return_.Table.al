table 50602 "Monthly Form of Return"
{
    Caption = 'Monthly Form of Return';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "License Type"; Text[100])
        {
            Caption = 'License Type';
            DataClassification = ToBeClassified;
        }
        field(3; Year; Integer)
        {
            Caption = 'Year';
            DataClassification = ToBeClassified;
        }
        field(4; Month; Text[50])
        {
            Caption = 'Month';
            DataClassification = ToBeClassified;
        }
        field(5; "Returning Officer's Name"; Text[100])
        {
            Caption = 'Returning Officer''s Name';
            DataClassification = ToBeClassified;
        }
        field(6; "Returning Officer Designation"; Text[100])
        {
            Caption = 'Returning Officer''s Designation';
            DataClassification = ToBeClassified;
        }
        field(7; Submit; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Applicant No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Licensing dairy Enterprise";

            trigger OnValidate()
            var
                Applic: record "Licensing dairy Enterprise";
                Licenses: Record "License and Permit Category";
                LicensesApp: Record "License Applications";
                MonthlyReturn: Record "Monthly Form of Return";
                App: record "Licensing dairy Enterprise";
                ReqDocuments: Record "Compliance Documents";
                LicensingDocs: Record "Licensing Required Documents";
            begin
                Applic.Reset();
                Applic.SetRange("Application no", "Applicant No.");
                if Applic.FindFirst()then //     Error('This applicant does not exist')
                // else 
                begin
                    if Applic."Customer Type" = Applic."Customer Type"::Individual then "Applicant Name":=Applic."First Name" + ' ' + Applic."Middle Name" + ' ' + Applic."Last Name";
                    if Applic."Customer Type" = Applic."Customer Type"::"Registered Entity" then "Applicant Name":=Applic."Business Name";
                    Name:="Applicant Name";
                    "Returning Officer's Name":=Name;
                    "Returning Officer Designation":=format(Applic.Salutation);
                    Address:=Applic."Postal Address";
                    "Telephone Number":=Applic."Cell Phone Number 1";
                    "Email Address":=lowercase(Applic."E-Mail");
                end;
                MonthlyReturn.SetRange("Applicant No.", "Applicant No.");
                MonthlyReturn.SetRange(Paid, false);
                if MonthlyReturn.FindFirst()then Error('Please pay previous returns before doing a new application');
                MonthlyReturn.Reset();
                MonthlyReturn.SetRange("Applicant No.", "Applicant No.");
                MonthlyReturn.SetFilter("No.", '<>%1', "No.");
                if MonthlyReturn.FindLast()then begin
                    "Date of Last Return":=MonthlyReturn."Base Date";
                end;
            end;
        }
        field(9; Submitted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Total Quantity"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Monthly Returns intake".Quantity where("Application No"=field("No.")));
        }
        field(11; "Cess Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Levy Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Total Amount"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                PaymentMgt: Codeunit "Payments Management";
                CurrencyCodeText: Code[10];
                AmountText: array[2]of Text;
            begin
                PaymentMgt.InitTextVariable;
                PaymentMgt.FormatNoText(AmountText, "Total Amount", CurrencyCodeText);
                "Amount in words":=AmountText[1];
            end;
        }
        field(14; "Cess Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Levy Penalty"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Base Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                if "Base Date" > Today then Error('Base date cannot be greater than today');
                Year:=Date2DMY("Base Date", 3);
                Month:=Format("Base Date", 0, '<Month Text>');
            end;
        }
        field(17; "No. Series"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; Invoiced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(19; Paid; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Invoice No."; Code[20])
        {
            Caption = 'Invoice No.';
            DataClassification = ToBeClassified;
        }
        field(21; "Amount Paid"; Decimal)
        {
            Caption = 'Amount';
            DataClassification = ToBeClassified;
        }
        field(23; "Receipt No."; Code[20])
        {
            Caption = 'Receipt No.';
            DataClassification = ToBeClassified;
        }
        field(24; "License No."; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Issued Applicant License"."License No." where("Applicant No."=field("Applicant No."));

            trigger OnValidate()
            var
                Licenses: Record "Issued Applicant License";
            begin
                UpdateLines();
                Licenses.SetRange("Applicant No.", "Applicant No.");
                Licenses.SetRange("License No.", "License No.");
                if Licenses.FindFirst()then begin
                    "License Type":=Licenses.Category;
                    Outlet:=Licenses.Outlet;
                end;
            //InsertProducts();
            end;
        }
        field(25; "QR Code Text"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "QR Code"; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Date of Last Return"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(28; Outlet; Code[100])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                myInt: Integer;
            begin
            end;
        }
        field(29; "Total Costs"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum("Monthly Returns intake"."Cost(Ksh.)" where("Application No"=field("No.")));
        }
        field(30; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(31; Address; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Email Address"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Telephone Number"; Code[13])
        {
            DataClassification = ToBeClassified;
        }
        field(34; Signature; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(35; Stamp; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(36; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(37; "Amount in words"; Text[2000])
        {
            DataClassification = ToBeClassified;
        }
        field(38; "Officer's No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Officer's Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Officer's Signature"; Blob)
        {
            DataClassification = ToBeClassified;
            Subtype = Bitmap;
        }
        field(41; "Officer signature Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(42; "Applicant Name"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(44; Defaulted; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(45; Acknowledge; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        myInt: Integer;
    begin
        CompSetup.Get();
        CompSetup.TestField("Monthly Returns No.");
        NoSeriesMgt.InitSeries(CompSetup."Monthly Returns No.", xRec."No. Series", TODAY, "No.", "No. Series");
        "Return Date":=Today;
    end;
    var PostCode: Record "Post Code";
    RecIntakes: Record "Monthly Returns intake";
    RecProducts: record "Monthly Returns  Product";
    CurrRecIntakes: Record "Monthly Returns intake";
    CurrRecProducts: record "Monthly Returns  Product";
    CompSetup: Record "Compliance Setup";
    Products: Record "Dairy Produce Setup";
    Intakes: Record "Monthly Return Intake Setup2";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    ProductsPerOutlet: Record "Applicants Products per outlet";
    // Products: Record "Compliance Products Setup";
    procedure UpdateLines()
    begin
        CurrRecIntakes.SetRange("Application No", "No.");
        if CurrRecIntakes.find('-')then CurrRecIntakes.deleteall;
        repeat RecIntakes.Init();
            RecIntakes."Application No":="No.";
            RecIntakes.Description:=Intakes.Description;
            RecIntakes.Type:=Intakes.Type;
            RecIntakes.Units:=Intakes.units;
            RecIntakes.Insert(true);
        until Intakes.Next() = 0;
    end;
    procedure InsertProducts()
    begin
        CurrRecProducts.SetRange("ApplicationNo", "No.");
        if CurrRecProducts.find('-')then CurrRecProducts.deleteall;
        // ProductsPerOutlet.Reset();
        // ProductsPerOutlet.SetRange("Application no", "Applicant No.");
        // ProductsPerOutlet.SetRange(Outlet, Outlet);
        // if ProductsPerOutlet.Find('-') then
        repeat RecProducts.Init();
            RecProducts.ApplicationNo:="No.";
            RecProducts.Product:=Products."Dairy Produce";
            RecProducts."Unit of Measure":=Products."Unit of measure";
            RecProducts.Insert(true);
        until Products.Next = 0;
    end;
}
