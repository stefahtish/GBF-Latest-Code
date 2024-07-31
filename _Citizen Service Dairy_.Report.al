report 50339 "Citizen Service Dairy"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CitizenServiceDStatistics.rdl';
    Caption = 'Citizen Service Dairy Industry Statistics';
    ApplicationArea = All;

    dataset
    {
        dataitem("Research Activity Plan"; "Research Activity Plan")
        {
            DataItemTableView = WHERE("Research Type" = filter(Dairystds));

            column(Code; Code)
            {
            }
            column(Description_of_activity; "Description of activity")
            {
            }
            column(Resolution; ResolutionNotesText)
            {
            }
            column(Problem; ProblemNotesText)
            {
            }
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
