report 50360 "Audit Working Paper"
{
    DefaultLayout = rdlc;
    RDLCLayout = './AuditWorkingPaper.rdl';
    WordLayout = 'AuditWorkingPaper.docx';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            column(CompanyName; CompanyInfo.Name)
            {
            }
            column(CompanyLogo; CompanyInfo.Picture)
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
            column(Date_AuditHeader; "Audit Header".Date)
            {
            }
            column(CreatedBy_AuditHeader; GetEmployeeName("Audit Header"."Created By"))
            {
            }
            column(Status_AuditHeader; "Audit Header".Status)
            {
            }
            column(CutOffPeriod_AuditHeader; "Audit Header"."Cut-Off Period")
            {
            }
            column(ReviewedBy_AuditHeader; "Audit Header"."Reviewed By")
            {
            }
            column(AuditManager_AuditHeader; "Audit Header"."Audit Manager")
            {
            }
            column(AuditFirm_AuditHeader; "Audit Header"."Audit Firm")
            {
            }
            column(ShortcutDimension2Code_AuditHeader; "Audit Header"."Shortcut Dimension 2 Code")
            {
            }
            column(Title_AuditHeader; "Audit Header".Title)
            {
            }
            column(FinancialYear; FinancialYear)
            {
            }
            column(DateCompleted; "Audit Header"."Date Completed")
            {
            }
            column(DateReviewed; "Audit Header"."Date Reviewed")
            {
            }
            column(Audit_Program_No_; "Audit Program No.")
            {
            }
            // column(Audit_Scope; GetScope("No."))
            // {
            // }
            // column(Audit_SampleData; GetSampleData("No."))
            // {
            // // }
            // column(Audit_Tests; GetTests("No."))
            // {
            // }
            // column(Audit_Queries; GetQueries("No."))
            // {
            // }
            // column(Audit_Results; GetResults("No."))
            // {
            // }
            // column(Audit_Conclusion; GetConclusion("No."))
            // {
            // }
            dataitem(WPScope; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("WorkPaper Scope"));

                column(Audit_Scope; "Description 2")
                {
                }
            }
            dataitem(WPArea; "Audit Areas")
            {
                DataItemLink = "No." = FIELD("No.");

                column(Audit_Area; "Audit plan area")
                {
                }
            }
            dataitem(WObjectives; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("WorkPaper Objectives"));

                column(Audit_Objective; D5NotesText)
                {
                }
                column(Number; Number)
                {
                }
                dataitem(Results; "Audit Lines")
                {
                    DataItemLink = "Document No." = FIELD("Document No."), "Audit Code" = field(Number);
                    DataItemTableView = where("Audit Line Type" = FILTER("WorkPaper Result"));

                    column(RNumber; Number)
                    {
                    }
                    column(Audit_Code; "Audit Code")
                    {
                    }
                    column(Result; DNotesTextD2)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        //Convert Description to Text
                        CALCFIELDS("Description 2 Blob");
                        "Description 2 Blob".CREATEINSTREAM(Instr);
                        DNotesD2.READ(Instr);
                        DNotesTextD2 := FORMAT(DNotesD2);
                        //End of Conversion
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    CALCFIELDS(Description);
                    Description.CREATEINSTREAM(Instr);
                    D5Notes.READ(Instr);
                    D5NotesText := FORMAT(D5Notes);
                    //End of Conversion
                end;
            }
            dataitem(WPSampleData; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("Sample Data Checked"));

                column(Audit_SampleData; D2NotesText)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    WPSampleData.CALCFIELDS(Description);
                    WPSampleData.Description.CREATEINSTREAM(Instr);
                    D2Notes.READ(Instr);
                    D2NotesText := FORMAT(D2Notes);
                    //End of Conversion
                end;
            }
            dataitem(WPTests; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Test));

                column(Audit_Tests; D3NotesText)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    // //Convert Description to Text
                    CALCFIELDS(Description);
                    Description.CREATEINSTREAM(Instr);
                    D3Notes.READ(Instr);
                    D3NotesText := FORMAT(D3Notes);
                    //End of Conversion
                end;
            }
            dataitem(Queries; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER(Queries));

                column(Query; D4NotesText)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    CALCFIELDS(Description);
                    Description.CREATEINSTREAM(Instr);
                    D4Notes.READ(Instr);
                    D4NotesText := FORMAT(D4Notes);
                    //End of Conversion
                end;
            }
            dataitem(Conclusions; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = where("Audit Line Type" = FILTER("WorkPaper Conclusion"));

                column(Conclusion; DNotesText)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    CALCFIELDS(Description);
                    Description.CREATEINSTREAM(Instr);
                    DNotes.READ(Instr);
                    DNotesText := FORMAT(DNotes);
                    //End of Conversion
                end;
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
                PrevYear: date;
                NextYear: date;
                FirstDate: Date;
            begin
                //Date2DMY("Date", 3);                
                PrevYear := CalcDate('-1Y', Date);
                NextYear := CalcDate('1Y', Date);
                Evaluate(FirstDate, '01/07/' + Format(Date2DMY(Date, 3)));
                if Date < FirstDate then
                    FinancialYear := Format(Date2DMY(PrevYear, 3)) + '/' + Format(Date2DMY(Date, 3))
                else
                    FinancialYear := Format(Date2DMY(Date, 3)) + '/' + Format(Date2DMY(NextYear, 3));
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
        InstrD2: InStream;
        DNotesD2: BigText;
        DNotesTextD2: Text;
        OutStrD2: OutStream;
        D1Notes: BigText;
        D1NotesText: Text;
        D2Notes: BigText;
        D2NotesText: Text;
        D3Notes: BigText;
        D3NotesText: Text;
        D4Notes: BigText;
        D4NotesText: Text;
        D5Notes: BigText;
        D5NotesText: Text;
        i: Integer;
        j: integer;
        FinancialYear: code[50];

    procedure GetEmployeeName(User: code[50]): Text
    var
        Usersetup: Record "User Setup";
        Employee: Record Employee;
    begin
        Usersetup.Reset();
        Usersetup.SetRange("User ID", User);
        if Usersetup.FindFirst() then begin
            Employee.Reset();
            Employee.SetRange("No.", Usersetup."Employee No.");
            if Employee.FindFirst() then exit(Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name")
        end;
    end;

    procedure GetCurrentYear(DocDate: Date): Text
    var
        AccPeriods: Record "Accounting Period";
    begin
        AccPeriods.Reset();
        AccPeriods.SetRange(Closed, false);
        AccPeriods.SetFilter("Starting Date", '<=%1', DocDate);
        if AccPeriods.FindFirst() then exit(AccPeriods.Name);
    end;
}
