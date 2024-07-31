report 50345 "Citizen Service D Media"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CitizenServiceDMedia.rdl';
    Caption = 'Citizen Service Delivery Charter';
    ApplicationArea = All;

    dataset
    {
        dataitem(ClientInteractionHeader; "Client Interaction Header")
        {
            DataItemTableView = where("Interaction Type" = filter(Enquiry));

            column(Interact_Code; "Interact Code")
            {
            }
            column(Datetime_Received; DT2Date("Datetime Claim Received"))
            {
            }
            column(Datetime_Acknowledged; DT2Date("Datetime Claim Assigned"))
            {
            }
            column(Closed_DateTime; DT2Date("Closed DateTime"))
            {
            }
            column(Resolution; ResolutionNotesText)
            {
            }
            column(Problem; ProblemNotesText)
            {
            }
            trigger OnAfterGetRecord()
            var
                myInt: Integer;
            begin
                CALCFIELDS("Problem Reported");
                "Problem Reported".CREATEINSTREAM(Instr);
                ProblemNote.READ(Instr);
                ProblemNotesText := FORMAT(ProblemNote);
                CALCFIELDS("Hr Comment");
                "Hr Comment".CREATEINSTREAM(Instr);
                ResolutionNote.READ(Instr);
                ResolutionNotesText := FORMAT(ResolutionNote);
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
