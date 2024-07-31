report 50426 "Quarterly Audit Plan"
{
    DefaultLayout = RDLC;
    RDLCLayout = './QuarterlyAuditPlan.rdl';
    Caption = 'Audit Plan';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            DataItemTableView = WHERE(Type = FILTER("Quarterly Audit"));

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
            column(AuditPeriod; "Audit Header"."Audit Period")
            {
            }
            column(Type; "Audit Header".Type)
            {
            }
            column(Title; Title)
            {
            }
            column(DepartmentName; "Audit Header"."Department Name")
            {
            }
            column(AuditStatus; "Audit Header"."Document Status")
            {
            }
            column(Year1; Year1)
            {
            }
            column(Year2; Year2)
            {
            }
            column(Year3; Year3)
            {
            }
            column(Introduction; IntroNotesText)
            {
            }
            column(ObjectivesStatement; ObjectivesNotesText)
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Objectives));

                column(Line_No_; Number)
                {
                }
                column(Findings; Findings)
                {
                }
                column(Recommendation; Recommendation)
                {
                }
                column(Audit_Subcategory; "Audit Subcategory")
                {
                }
                column(MgmtResponse; DNotesText)
                {
                }
                column(Timeline; Timeline)
                {
                }
                column(Remarks; Remarks)
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
            trigger OnAfterGetRecord()
            var
                Periods: record "Audit Period";
            begin
                CALCFIELDS(Introduction, "Objectives Statement");
                Introduction.CREATEINSTREAM(Instr);
                IntroNote.READ(Instr);
                IntroNotesText := Format(IntroNote);
                "Objectives Statement".CREATEINSTREAM(Instr);
                ObjectivesNote.READ(Instr);
                ObjectivesNotesText := Format(ObjectivesNote);
                Periods.Reset();
                Periods.SetRange(Period, "Audit Period");
                if Periods.FindFirst() then begin
                    StartDate := Periods."Period Start";
                end;
            end;
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
        TotalDays: Text[200];
        IntroNote: BigText;
        IntroNotesText: Text;
        ObjectivesNote: BigText;
        ObjectivesNotesText: Text;
        Year1: code[100];
        Year2: Code[100];
        Year3: code[100];
        StartDate: date;

    local procedure GetDepartmentName(DeptCode: Code[20]): Text[150]
    begin
        DimensionVal.Reset;
        DimensionVal.SetRange(Code, DeptCode);
        if DimensionVal.Find('-') then exit(DimensionVal.Name);
    end;

    procedure GetFinancialYear(): Code[20]
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.get;
        exit(GLSetup."Current Budget");
    end;
}
