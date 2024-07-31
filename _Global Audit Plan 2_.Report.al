report 50368 "Global Audit Plan 2"
{
    DefaultLayout = RDLC;
    RDLCLayout = './GlobalAuditPlan2.rdlc';
    Caption = 'Audit Plan';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            DataItemTableView = WHERE(Type = FILTER("Audit Program"));

            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompLogo; CompanyInfo.Picture)
            {
            }
            column(CompPostCode; CompanyInfo."Post Code")
            {
            }
            column(CompEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompWebsite; CompanyInfo."Home Page")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(No_AuditHeader; "Audit Header"."No.")
            {
            }
            column(ShortcutDimension1Code; "Audit Header"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; GetDepartmentName("Audit Header"."Shortcut Dimension 2 Code"))
            {
            }
            column(AuditPeriod; "Audit Header"."Audit Period Start Date")
            {
            }
            column(Type; "Audit Header".Type)
            {
            }
            column(DepartmentName; "Audit Header"."Department Name")
            {
            }
            column(AuditStatus; "Audit Header"."Audit Status")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");

                column(AuditType; "Audit Lines"."Audit Type")
                {
                }
                column(Description; DNotesText)
                {
                }
                column(AuditTypeDescription; "Audit Lines"."Audit Type Description")
                {
                }
                column(StartDate; "Audit Lines"."Start Date")
                {
                }
                column(EndDate; "Audit Lines"."End Date")
                {
                }
                column(RiskRating; "Audit Lines"."Assessment Rating")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    "Audit Lines".CalcFields(Description);
                    "Audit Lines".Description.CreateInStream(Instr);
                    DNotes.Read(Instr);
                    DNotesText := Format(DNotes);
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPreReport()
    begin
        CompanyInfo.Get;
        CompanyInfo.CalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        DimensionVal: Record "Dimension Value";
        AuditFile: Text[250];

    local procedure GetDepartmentName(DeptCode: Code[20]): Text[150]
    begin
        DimensionVal.Reset;
        DimensionVal.SetRange(Code, DeptCode);
        if DimensionVal.Find('-') then exit(DimensionVal.Name);
    end;
}
