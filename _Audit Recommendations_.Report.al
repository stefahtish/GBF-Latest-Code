report 50375 "Audit Recommendations"
{
    DefaultLayout = RDLC;
    RDLCLayout = './AuditRecommendations.rdlc';
    ApplicationArea = All;

    dataset
    {
        dataitem("Audit Recommendations"; "Audit Recommendations")
        {
            column(CompName; CompanyInfo.Name)
            {
            }
            column(CompAddr; CompanyInfo.Address)
            {
            }
            column(CompAddr2; CompanyInfo."Address 2")
            {
            }
            column(CompCity; CompanyInfo.City)
            {
            }
            column(CompPhone; CompanyInfo."Phone No.")
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
            column(CompHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompCountry; CompanyInfo."Country/Region Code")
            {
            }
            column(DocumentNo; "Audit Recommendations"."Document No.")
            {
            }
            column(AuditObservation; ObsNoteText)
            {
            }
            column(AuditRecommendation; RecomNoteText)
            {
            }
            column(ManagementResponse; "Audit Recommendations"."Management Response")
            {
            }
            column(ImplementationDate; "Audit Recommendations"."Implementation Date")
            {
            }
            column(DepartmentResponsible; "Audit Recommendations"."Department Responsible")
            {
            }
            column(DepartmentName; "Audit Recommendations"."Department Name")
            {
            }
            column(Status; "Audit Recommendations".Status)
            {
            }
            column(Comments; "Audit Recommendations".Comments)
            {
            }
            column(NewRecommendation; "Audit Recommendations"."New Recommendation")
            {
            }
            column(ShortcutDimension1Code; "Audit Recommendations"."Shortcut Dimension 1 Code")
            {
            }
            column(ShortcutDimension2Code; "Audit Recommendations"."Shortcut Dimension 2 Code")
            {
            }
            column(RowCount; RowCount)
            {
            }
            column(Implemented; Implemented)
            {
            }
            trigger OnAfterGetRecord()
            begin
                //Observation
                CalcFields("Audit Observation");
                "Audit Observation".CreateInStream(ObsInstr);
                ObsNote.Read(ObsInstr);
                ObsNoteText := Format(ObsNote);
                //Recomendation
                CalcFields("Audit Recommendation");
                "Audit Recommendation".CreateInStream(RecomInstr);
                RecomNote.Read(RecomInstr);
                RecomNoteText := Format(RecomNote);
                RowCount := Count;
                /*
                    "Audit Recommendations".RESET;
                    "Audit Recommendations".SETRANGE(Status,"Audit Recommendations".Status::Implemented);
                    IF "Audit Recommendations".FIND('-') THEN
                      BEGIN
                        Implemented := "Audit Recommendations".COUNT;
                      END;
                    */
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
    var
        CompanyInfo: Record "Company Information";
        ObsNote: BigText;
        ObsNoteText: Text;
        ObsInstr: InStream;
        ObstOutstr: OutStream;
        RecomNote: BigText;
        RecomNoteText: Text;
        RecomInstr: InStream;
        RecomOutstr: OutStream;
        RowCount: Integer;
        Implemented: Integer;
}
