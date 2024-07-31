report 50361 "Internal Audit Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = './InternalAuditReport.rdl';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Header"; "Audit Header")
        {
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompLogo; CompanyInfo.Picture)
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
            column(No; "Audit Header"."No.")
            {
            }
            column(Date; "Audit Header".Date)
            {
            }
            column(CreatedBy; "Audit Header"."Created By")
            {
            }
            column(ShortcutDimension2Code; "Audit Header"."Shortcut Dimension 2 Code")
            {
            }
            column(ShortcutDimension1Code; "Audit Header"."Shortcut Dimension 1 Code")
            {
            }
            dataitem("Audit Lines"; "Audit Lines")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = SORTING("Document No.", "Audit Line Type", "Audit Code", "Line No.") ORDER(Ascending);

                column(Description; DNotesText)
                {
                }
                column(RiskRating; "Audit Lines"."Risk Rating")
                {
                }
                column(Reference; "Audit Lines".Reference)
                {
                }
                column(Date_Lines; "Audit Lines".Date)
                {
                }
                column(AuditLineType; "Audit Lines"."Audit Line Type")
                {
                }
                column(LineNo_AuditLines; "Audit Lines"."Line No.")
                {
                }
                column(ImplicationText; ImplicationNotesText)
                {
                }
                column(CriteriaText; CriteriaNotesTxt)
                {
                }
                column(ObservationText; ObservationNotesTxt)
                {
                }
                column(ResponseText; "Audit Lines".Remarks)
                {
                }
                column(ResponsiblePersonnel; "Audit Lines"."Responsible Personnel")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    //Convert Description to Text
                    CALCFIELDS(Description);
                    Description.CREATEINSTREAM(Instr);
                    DNotes.READ(Instr);
                    DNotesText := FORMAT(DNotes);
                    CALCFIELDS("Risk Implication");
                    "Risk Implication".CREATEINSTREAM(ImplicationInstr);
                    ImplicationNotes.READ(ImplicationInstr);
                    ImplicationNotesText := FORMAT(ImplicationNotes);
                    CALCFIELDS(Criteria);
                    Criteria.CREATEINSTREAM(CriteriaInstr);
                    CriteriaNotes.READ(CriteriaInstr);
                    CriteriaNotesTxt := FORMAT(CriteriaNotes);
                    CALCFIELDS("Observation/Condition");
                    "Observation/Condition".CREATEINSTREAM(ObsInstr);
                    ObservationNotes.READ(ObsInstr);
                    ObservationNotesTxt := FORMAT(ObservationNotes);
                    CALCFIELDS("Action Plan / Mgt Response");
                    "Action Plan / Mgt Response".CREATEINSTREAM(ResponseInstr);
                    ResponseNotes.READ(ResponseInstr);
                    ResponseNotesTxt := FORMAT(ResponseNotes);
                    //End of Conversion
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
        CompanyInfo.GET;
        CompanyInfo.CALCFIELDS(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        Instr: InStream;
        DNotes: BigText;
        DNotesText: Text;
        OutStr: OutStream;
        AuditLine: Record "Audit Lines";
        ImplicationNotes: BigText;
        ImplicationNotesText: Text;
        CriteriaNotes: BigText;
        CriteriaNotesTxt: Text;
        ObservationNotes: BigText;
        ObservationNotesTxt: Text;
        ResponseNotes: BigText;
        ResponseNotesTxt: Text;
        ImplicationInstr: InStream;
        ImplicationOutStr: OutStream;
        CriteriaInstr: InStream;
        CriteriaOutStr: OutStream;
        ObsInstr: InStream;
        ObsOutStr: OutStream;
        ResponseInstr: InStream;
        ResponseOutStr: OutStream;
}
