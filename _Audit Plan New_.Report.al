report 50351 "Audit Plan New"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AuditPlanNew.rdl';
    Caption = 'Audit Plan';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            DataItemTableView = WHERE(Type = FILTER("Audit Plan"));

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
            column(AuditStatus; "Audit Header"."Document Status")
            {
            }
            column(Introduction; IntroNotesText)
            {
            }
            column(ObjectivesStatement; ObjectivesNotesText)
            {
            }
            dataitem("Audit Areas"; "Audit Areas")
            {
                DataItemLink = "No." = field("No.");

                column(Audit_area; "Audit plan area")
                {
                }
                dataitem("Audit Areas Subsections"; "Audit Areas Subsections")
                {
                    DataItemLink = "No." = field("No."), "Audit plan area" = field("Audit plan area");

                    column(Subsection; Subsection)
                    {
                    }
                    column(Audit_plan_area; "Audit plan area")
                    {
                    }
                }
            }
            dataitem("Audit Objectives"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Objectives));

                column(Line_No_; Number)
                {
                }
                column(Description_2; "Description 2")
                {
                }
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("Audit Plan"));

                column(AuditType; "Audit Lines"."Audit Type")
                {
                }
                column(Description; DNotesText)
                {
                }
                column(AuditTypeDescription; "Audit Lines"."Audit Type Description")
                {
                }
                column(Review_Type; "Review Type")
                {
                }
                column(TotalDays; TotalDays)
                {
                }
                column(FieldWork; FieldWork)
                {
                }
                column(Phase; Phase)
                {
                }
                column(Days; Days)
                {
                }
                column(Report_to_Audit_Committee; "Report to Audit Committee")
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
                    if "Review Type" = "Review Type"::"Risk based review" then TotalDays := 'Total risk-based days';
                    if "Review Type" = "Review Type"::"Other Review" then TotalDays := 'Total other review days';
                    if "Review Type" = "Review Type"::Other then TotalDays := 'Total other days';
                    if "Review Type" = "Review Type"::" " then TotalDays := 'Total days';
                end;
            }
            dataitem("Audit Perfomance"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Indicators));

                column(PAuditType; "Audit Lines"."Audit Type")
                {
                }
                column(Indicator; Indicator)
                {
                }
                column(Target; Target)
                {
                }
            }
            dataitem("Audit Budget"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Budget));

                column(Quarter; Quarter)
                {
                }
                column(Total_Amount; "Total Amount")
                {
                }
                column(FinancialYear; GetFinancialYear())
                {
                }
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CALCFIELDS(Introduction, "Objectives Statement");
                Introduction.CREATEINSTREAM(Instr);
                IntroNote.READ(Instr);
                IntroNotesText := Format(IntroNote);
                "Objectives Statement".CREATEINSTREAM(Instr);
                ObjectivesNote.READ(Instr);
                ObjectivesNotesText := Format(ObjectivesNote)
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
