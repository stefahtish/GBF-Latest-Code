report 50343 "Citizen Service D Payments"
{
    DefaultLayout = RDLC;
    RDLCLayout = './CitizenServiceDPayments.rdl';
    Caption = 'Citizen Service Delivery';
    ApplicationArea = All;

    dataset
    {
        dataitem("Purch. Inv. Header"; "Purch. Inv. Header")
        {
            column(No_; "No.")
            {
            }
            column(Document_Date; "Document Date")
            {
            }
            column(Vendor_Invoice_No_; "Vendor Invoice No.")
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
