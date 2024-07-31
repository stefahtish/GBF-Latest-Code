page 50260 "Delegate Profile"
{
    DeleteAllowed = false;
    PageType = Card;
    SourceTable = "Delegate User Profile";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    Editable = false;
                }
                field("Date Created"; Rec."Date Created")
                {
                    Editable = false;
                }
                field("Time Created"; Rec."Time Created")
                {
                    Editable = false;
                }
                field("User ID"; Rec."User ID")
                {
                }
                field("Current Profile"; Rec."Current Profile")
                {
                    Editable = false;
                }
                field(Company; Rec.Company)
                {
                    Caption = 'Current Company';
                    Editable = false;
                }
                field("New Profile"; Rec."New Profile")
                {
                }
                field("New Company"; Rec."New Company")
                {
                    Visible = false;
                }
                field(From; Rec.From)
                {
                    Caption = 'From Date';
                }
                field("To Date"; Rec."To Date")
                {
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                }
                field("Assigned By"; Rec."Assigned By")
                {
                    Editable = false;
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Delegate)
            {
                Caption = 'Delegate Profile';
                Image = Delegate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Visible = Rec."Status" = Rec."Status"::"New";

                trigger OnAction()
                begin
                    Rec.TestField(Status, Rec.Status::New);
                    if Confirm('Are you sure you want to delegate?', false) = true then begin
                        Rec.Delegate;
                        Message('Delegated Successfully')
                    end;
                    Commit;
                    CurrPage.Close;
                end;
            }
        }
    }
}
