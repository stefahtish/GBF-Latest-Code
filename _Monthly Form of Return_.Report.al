report 50349 "Monthly Form of Return"
{
    RDLCLayout = './Monthly ReturnReport.rdl';
    WordLayout = './MonthlyFormReturnReport.docx';
    DefaultLayout = Word;
    ApplicationArea = All;

    dataset
    {
        dataitem(MonthlyFormofReturn2; "Monthly Form of Return")
        {
            column(CompanyLogo; CompanyInfo.Picture)
            {
            }
            column(Name; Name)
            {
            }
            column(Telephone_Number; "Telephone Number")
            {
            }
            column(Address; Address)
            {
            }
            column(Email_Address; Sentenceformat("Email Address"))
            {
            }
            column(Total_Amount; "Total Amount")
            {
            }
            column(Total_Quantity; "Total Quantity")
            {
            }
            column(Levy_Amount; "Levy Amount")
            {
            }
            column(Levy_Penalty; "Levy Penalty")
            {
            }
            column(Amount_in_words; "Amount in words")
            {
            }
            column(Signature; Signature)
            {
            }
            column(Stamp; Stamp)
            {
            }
            column(Date; format(MonthlyFormofReturn2."Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Officer_signature_Date; "Officer signature Date")
            {
            }
            column(Officer_s_Name; "Officer's Name")
            {
            }
            column(Officer_s_No; "Officer's No")
            {
            }
            column(Officer_s_Signature; "Officer's Signature")
            {
            }
            column(Month; Month)
            {
            }
            column(Year; Year)
            {
            }
            column(Return_Date; "Return Date")
            {
            }
            column(Returning_Officer_Designation; "Returning Officer Designation")
            {
            }
            column(Returning_Officer_s_Name; "Returning Officer's Name")
            {
            }
            column(Permits; Permits)
            {
            }
            column(Invoice_No_; "Invoice No.")
            {
            }
            column(Receipt_No_; "Receipt No.")
            {
            }
            dataitem("Monthly Returns  Product"; "Monthly Returns  Product")
            {
                DataItemLink = ApplicationNo = field("No.");
                DataItemTableView = where(Quantity = filter(> 0));

                column(ApplicationNo; ApplicationNo)
                {
                }
                column(Product_Prod; UPPERCASE(COPYSTR(Product, 1, 1)) + LOWERCASE(DELSTR(Product, 1, 1)))
                {
                }
                column(Quantity_Prod; Quantity)
                {
                }
                column(Unit_of_Measure_Prod; UPPERCASE(COPYSTR("Unit of Measure", 1, 1)) + LOWERCASE(DELSTR("Unit of Measure", 1, 1)))
                {
                }
                dataitem(SubProduct; "Monthly Returns  Product")
                {
                    DataItemLink = ApplicationNo = field(ApplicationNo), SubProduct = field(Product);
                    DataItemTableView = where(Quantity = filter(> 0));

                    column(SubProduct_SubProd; SubProduct)
                    {
                    }
                    column(Product_SubProd; UPPERCASE(COPYSTR(Product, 1, 1)) + LOWERCASE(DELSTR(Product, 1, 1)))
                    {
                    }
                    column(Quantity_SubProd; Quantity)
                    {
                    }
                    column(Unit_of_Measure_SubProd; UPPERCASE(COPYSTR("Unit of Measure", 1, 1)) + LOWERCASE(DELSTR("Unit of Measure", 1, 1)))
                    {
                    }
                }
            }
            dataitem("Monthly Returns intake"; "Monthly Returns intake")
            {
                DataItemLink = "Application No" = field("No.");
                DataItemTableView = where(Quantity = filter(> 0));

                column(Application_No_intake; "Application No")
                {
                }
                column(Description_intake; Description)
                {
                }
                column(Units_intake; Units)
                {
                }
                column(Quantity_intake; Quantity)
                {
                }
                column(Cost_Ksh_intake; "Cost(Ksh.)")
                {
                }
                column(Unit_Cost_per_litre_intake; "Unit Cost per litre")
                {
                }
                column(Line_No_intake; "Line No.")
                {
                }
                column(Source_intake; Source)
                {
                }
                column(StringNo; StringNo)
                {
                }
                trigger OnAfterGetRecord()
                var
                    Products: Record "Monthly Returns intake";
                begin
                    Products.Reset();
                    Products.SetRange("Application No", MonthlyFormofReturn2."No.");
                    if Products.FindFirst() then
                        StringNo := 'a'
                    else begin
                    end;
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                Permits := GetPemits("No.");
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
        Permits: Text[1000];
        i: Integer;
        j: Integer;
        StringNo: Text[10];
        StringsArray: Text[30];

    local procedure GetPemits(DocNo: Code[50]): Text
    var
        AppLicenses: Record "Issued Applicant License";
        ReturnHeader: Record "Monthly Form of Return";
        License: array[50] of Text;
        Licenses: Text;
    begin
        if ReturnHeader.Get(DocNo) then begin
            i := 0;
            AppLicenses.Reset;
            AppLicenses.SetRange("Applicant No.", ReturnHeader."No.");
            if AppLicenses.Find('-') then begin
                repeat
                    i := i + 1;
                    License[i] := AppLicenses."License No.";
                until AppLicenses.Next = 0;
                for j := 1 to i do begin
                    if j = 1 then
                        Licenses := License[j]
                    else
                        Licenses := Licenses + ',' + License[j];
                end;
            end;
        end;
        exit(Licenses);
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

    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
}
