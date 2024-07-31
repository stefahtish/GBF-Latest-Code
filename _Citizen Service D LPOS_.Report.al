report 50342 "Citizen Service D LPOS"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CitizenServiceDLPOS.rdl';
    Caption = 'Citizen Service Delivery';
    ApplicationArea = All;

    dataset
    {
        dataitem("Procurement Request"; "Procurement Request")
        {
            DataItemTableView = where("Process Type" = filter(Tender));

            column(No_; "No.")
            {
            }
            column(Creation_Date; "Creation Date")
            {
            }
            // column()
            // {
            // }
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
