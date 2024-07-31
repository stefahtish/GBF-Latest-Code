report 50424 "License File"
{
    Caption = 'License File';
    DefaultLayout = RDLC;
    RDLCLayout = './License.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem(LicenseApplications; "License Applications")
        {
            column(ApplicantNo; "Applicant No.")
            {
            }
            column(LicenseNo; "License No.")
            {
            }
            column(RenewalLicenseNo; "Renewal License No.")
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(ExpiryDate; "Expiry Date")
            {
            }
            column(IssuedDate; "Issued Date")
            {
            }
            column(Category; Category)
            {
            }
            column(No; "No.")
            {
            }
            column(BodyNotesText; LicenseNotesText)
            {
            }
            column(QR_Code; "QR Code")
            {
            }
            column(Products; Products)
            {
            }
            column(AreasOfSale; AreasOfSale)
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(SaleToWhom; SaleToWhom)
            {
            }
            column(Background; ComplianceSetup."License Background image")
            {
            }
            dataitem(Registrations; "Licensing dairy Enterprise")
            {
                DataItemLink = "Application no" = field("Applicant No.");

                column(First_Name; "First Name")
                {
                }
                column(Last_Name; "Last Name")
                {
                }
                column(Middle_Name; "Middle Name")
                {
                }
                column(Postal_Address; "Postal Address")
                {
                }
                column(Station; Station)
                {
                }
                column(Physical_Address_Street_Road; "Physical Address(Street/Road")
                {
                }
                column(Cell_Phone_Number_1; "Cell Phone Number 1")
                {
                }
                column(E_Mail; SentenceFormat("E-Mail"))
                {
                }
            }
            dataitem("License Notes Setup"; "License Notes Setup")
            {
                column(Line_No_; "Line No.")
                {
                }
                column(Note; Note)
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                LicenseAppBranches: Record "Applicants Products per outlet";
            begin
                ComplianceSetup.Get;
                ComplianceSetup.CALCFIELDS(Notes);
                ComplianceSetup.Notes.CREATEINSTREAM(Instr);
                ComplianceSetup.CalcFields("License Background image");
                LicenseNote.READ(Instr);
                LicenseNotesText := FORMAT(LicenseNote);
                //Message(LicenseNotesText);
                LicenseAppBranches.Reset();
                LicenseAppBranches.SetRange("Application no", "Applicant No.");
                LicenseAppBranches.SetRange(Outlet, Outlet);
                if LicenseAppBranches.Find('-') then begin
                    LicenseAppBranches.CalcSums("Quantity handled");
                    Quantity := LicenseAppBranches."Quantity handled";
                    SaleToWhom := LicenseAppBranches."Sell to whom";
                end;
                Products := GetNatureOfProduce(LicenseApplications."Applicant No.");
                AreasOfSale := GetAreaOfSale(LicenseApplications."Applicant No.");
                //QR Code
                // QRCOdeGen.GenerateQRCode(LicenseApplications.RecordId);
                Commit();
                LicenseApplications.CalcFields("QR Code");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    var
        ComplianceSetup: Record "Compliance Setup";
        LicenseNote: BigText;
        LicenseNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        //QRCOdeGen: codeunit "QR Code Generation";
        NatureOfProduce: Text;
        Quantity: Decimal;
        SaleToWhom: Text;
        Products: text;
        QuantityHandled: Decimal;
        AreasOfSale: text;

    local procedure GetNatureOfProduce(AppNo: Code[50]): Text
    var
        LicenseApp: Record "License Applications";
        Products: Text;
        ProductArray: array[50] of Text;
        LicenseAppBranches: Record "Applicants Products per outlet";
        i: Integer;
        j: Integer;
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("Applicant No.", AppNo);
        if LicenseApp.FindFirst() then begin
            i := 0;
            LicenseAppBranches.Reset;
            LicenseAppBranches.SetRange("Application no", LicenseApp."Applicant No.");
            LicenseAppBranches.SetRange(Outlet, LicenseApp.Outlet);
            if LicenseAppBranches.Find('-') then begin
                repeat
                    i := i + 1;
                    ProductArray[i] := SentenceFormat(LicenseAppBranches.Product);
                until LicenseAppBranches.Next = 0;
                for j := 1 to i do begin
                    if j = 1 then
                        Products := ProductArray[j]
                    else
                        Products := Products + ',' + ProductArray[j];
                end;
            end;
        end;
        exit(Products);
    end;

    local procedure GetAreaOfSale(AppNo: Code[50]): Text
    var
        LicenseApp: Record "License Applications";
        Areas: Text;
        AreaArray: array[50] of Text;
        LicenseAppBranches: Record "Applicant product area of sale";
        i: Integer;
        j: Integer;
    begin
        LicenseApp.Reset();
        LicenseApp.SetRange("Applicant No.", AppNo);
        if LicenseApp.FindFirst() then begin
            i := 0;
            LicenseAppBranches.Reset;
            LicenseAppBranches.SetRange("Applicant no", LicenseApp."Applicant No.");
            LicenseAppBranches.SetRange(Outlet, LicenseApp.Outlet);
            if LicenseAppBranches.Find('-') then begin
                repeat
                    i := i + 1;
                    AreaArray[i] := SentenceFormat(LicenseAppBranches."Area of sale name");
                until LicenseAppBranches.Next = 0;
                for j := 1 to i do begin
                    if j = 1 then
                        Areas := AreaArray[j]
                    else
                        Areas := Areas + ',' + AreaArray[j];
                end;
            end;
        end;
        exit(Areas);
    end;

    procedure SentenceFormat(Name: Text[1000]): Text[1000]
    var
        I: Integer;
    begin
        For I := 1 to Strlen(name) do begin
            if I = 1 then
                EVALUATE(Name[I], LOWERCASE(FORMAT(Name[I])))
            else IF Name[I - 1] = 32 THEN
                EVALUATE(Name[I], LOWERCASE(FORMAT(Name[I])))
            ELSE
                EVALUATE(Name[I], LOWERCASE(FORMAT(Name[I])));
        end;
        EXIT(Name);
    end;
}
