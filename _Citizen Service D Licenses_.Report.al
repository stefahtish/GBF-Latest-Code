report 50341 "Citizen Service D Licenses"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CitizenServiceDLicenses.rdl';
    Caption = 'Citizen Service Delivery';
    ApplicationArea = All;

    dataset
    {
        dataitem("License Applications"; "License Applications")
        {
            DataItemTableView = where("Application Type" = const(Application));

            column(Applicant_No_; "Applicant No.")
            {
            }
            column(Application_Date; "Application Date")
            {
            }
            column(Issued_Date; "Issued Date")
            {
            }
            column(License_No_; "License No.")
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
            end;
        }
        dataitem("Citizen Service Delivery Setup"; "Citizen Service Delivery Setup")
        {
            column(Service_Rendered; ServiceNoteText)
            {
            }
            column(Requirement; Requirement)
            {
            }
            column(Charges; Charges)
            {
            }
            column(Timelines; Timelines)
            {
            }
            trigger OnAfterGetRecord()
            begin
                CalcFields("Service Rendered");
                "Service Rendered".CreateInStream(Instr);
                ServiceNote.READ(Instr);
                ServiceNoteText := Format(ServiceNote);
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
        ResolutionNote: BigText;
        ResolutionNotesText: Text;
        ProblemNote: BigText;
        ProblemNotesText: Text;
        Instr: InStream;
        OutStr: OutStream;
        ServiceNote: BigText;
        ServiceNoteText: Text;
}
