page 50888 Enquiries
{
    Caption = 'Visior''s Interaction Books';
    CardPageID = "Enquiries Book";
    PageType = List;
    SourceTable = "Enquiries Book";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                Caption = 'General';

                field("Serial Number"; Rec."Serial Number")
                {
                }
                field("Name of Customer"; Rec."Name of Customer")
                {
                }
                field("I.D No."; Rec."I.D No.")
                {
                }
                field("SF No."; Rec."SF No.")
                {
                }
                field("Phone Number"; Rec."Phone Number")
                {
                }
                field("Complaint/Request Submitted"; Rec."Complaint/Request Submitted")
                {
                }
                field("Customer Remarks"; Rec."Customer Remarks")
                {
                }
                field("Time In"; Rec."TimeIn")
                {
                }
                field("Time Out"; Rec."TimeOut")
                {
                }
                field("Satisfaction Level"; Rec."Satisfaction Level")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Approvals)
            {
                action(Close)
                {
                    Caption = 'Close';

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to close this Case?', false) = true then Rec.Status := Rec.Status::Closed;
                        Rec.Modify;
                    end;
                }
            }
        }
    }
}
