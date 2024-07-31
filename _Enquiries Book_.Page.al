page 50882 "Enquiries Book"
{
    Caption = 'Visitor''s Interaction Book';
    PageType = Card;
    SourceTable = "Enquiries Book";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Serial Number"; Rec."Serial Number")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Visitor type"; Rec."Visitor type")
                {
                    Enabled = OpenVisible;
                }
                field("Name of Customer"; Rec."Name of Customer")
                {
                    Enabled = OpenVisible;
                    caption = 'Visitor''s Name';
                    ApplicationArea = All;
                }
                field("Company From"; Rec."Company From")
                {
                    Enabled = OpenVisible;
                }
                field("Date of Visit"; Rec."Date of Visit")
                {
                    Enabled = OpenVisible;
                    Caption = 'Date';
                    ApplicationArea = All;
                }
                field("Purpose of Visit"; Rec."Purpose of Visit")
                {
                    Enabled = OpenVisible;
                    ApplicationArea = All;
                }
                field(Appointment; Rec.Appointment)
                {
                    Enabled = OpenVisible;
                    ApplicationArea = All;
                }
                field("Customer Remarks"; Rec."Customer Remarks")
                {
                    Enabled = OpenVisible;
                    Caption = 'Reason';
                    ApplicationArea = All;
                }
                field("Phone Number"; Rec."Phone Number")
                {
                    Enabled = OpenVisible;
                    ApplicationArea = All;
                }
                field(Email; Rec.Email)
                {
                    Enabled = OpenVisible;
                    ApplicationArea = All;
                }
                field("Refererred By"; Rec."Refererred By")
                {
                    Enabled = OpenVisible;
                }
                field("Visitor's Signature"; Rec."Visitor's Signature")
                {
                    Enabled = OpenVisible;
                    ApplicationArea = All;
                }
                group("Officer's Details")
                {
                    ShowCaption = false;

                    field("Visiting Department"; Rec."Visiting Department")
                    {
                        Enabled = OpenVisible;
                    }
                    field("Officer to be seen no."; Rec."Officer to be seen no.")
                    {
                        Enabled = OpenVisible;
                    }
                    field("Name of Officer to be seen"; Rec."Name of Officer to be seen")
                    {
                        Enabled = OpenVisible;
                    }
                    field("Officer's Email"; Rec."Officer's Email")
                    {
                        Enabled = OpenVisible;
                    }
                    field("Signature Officer to be seen"; Rec."Signature Officer to be seen")
                    {
                        ApplicationArea = All;
                        Enabled = OpenVisible;
                    }
                    field("Assign Remarks"; Rec."Assign Remarks")
                    {
                        Enabled = OpenVisible;
                    }
                    field("Officer's Decision"; Rec."Officer's Decision")
                    {
                        Enabled = Officerisible;
                    }
                    field("Officer's Decision Time"; Rec."Officer's Decision Time")
                    {
                        Enabled = false;
                    }
                }
                field("Time In"; Rec."TimeIn")
                {
                    ApplicationArea = All;
                    Enabled = OpenVisible;
                }
                field("Time Out"; Rec."TimeOut")
                {
                    ApplicationArea = All;
                    Enabled = false;
                    Visible = ClosedVisible;
                }
                field("Satisfaction Level"; Rec."Satisfaction Level")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field(Duration; Rec.Duration)
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    Enabled = OpenVisible;
                }
                field("I.D No."; Rec."I.D No.")
                {
                    Enabled = OpenVisible;
                    ApplicationArea = All;
                }
                field("SF No."; Rec."SF No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Receptionist Email"; Rec."Receptionist Email")
                {
                    Enabled = OpenVisible;
                }
                field("Complaint/Request Submitted"; Rec."Complaint/Request Submitted")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
            part(Control1000000029; "Enquiries Remarks")
            {
                Visible = false;
                Enabled = OpenVisible;
                SubPageLink = "Serial No." = FIELD("Serial Number");
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group(Process)
            {
                action(Close)
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Caption = 'Close';
                    Visible = Rec.Status = Rec.Status::Receptionist;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        if Confirm('Are you sure you want to close this Case?', false) = true then begin
                            Rec.TimeOut := time;
                            Rec.Status := Rec.Status::Closed;
                        end;
                        Rec.Modify;
                    end;
                }
                action("Notify Officer")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = Rec.Status = Rec.Status::Open;
                    PromotedIsBig = true;

                    trigger OnAction()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        Rec.TestField("Name of Customer");
                        Rec.TestField("Officer to be seen no.");
                        Rec.TestField("Officer's Email");
                        CompanyInfo.get();
                        CompanyInfo.TestField("E-Mail");
                        Clear(Receipients);
                        Receipients.add(Rec."Officer's Email");
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyName;
                        Body := Rec."Assign Remarks";
                        Subject := Format(Rec."Name of Customer");
                        SMTP.Create(Receipients, Subject, '', true);
                        SMTP.AppendtoBody(Body);
                        // Email.Send(SMTP);
                        Rec.Status := Rec.Status::Forwarded;
                        Rec.Modify();
                    end;
                }
                action("Notify Receptionist")
                {
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Visible = Rec.Status = Rec.Status::Forwarded;

                    trigger OnAction()
                    var
                        CompanyInfo: Record "Company Information";
                    begin
                        Rec.TestField("Officer's Decision");
                        Rec.TestField("Receptionist Email");
                        CompanyInfo.get();
                        CompanyInfo.TestField("E-Mail");
                        Clear(Receipients);
                        Receipients.add(Rec."Receptionist Email");
                        SenderAddress := CompanyInfo."E-Mail";
                        SenderName := CompanyName;
                        Body := 'This is to notify you that I have %1 to be seen by %2';
                        Subject := Format(Rec."Name of Customer");
                        SMTP.Create(Receipients, Subject, '', true);
                        SMTP.AppendtoBody(StrSubstNo(Body, Rec."Officer's Decision", Rec."Name of Customer"));
                        // Email.Send(SMTP);
                        Rec."Officer's Decision Time" := time;
                        Rec.Status := Rec.Status::Receptionist;
                        Rec.Modify();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    trigger OnAfterGetRecord()
    var
        myInt: Integer;
    begin
        SetControlAppearance();
    end;

    var
        SenderAddress: Text[80];
        Receipients: List of [Text];
        Subject: Text[150];
        Body: Text;
        SenderName: Text[80];
        SMTP: Codeunit "Email Message";
        Email: Codeunit Email;
        OpenVisible: Boolean;
        Officerisible: Boolean;
        ClosedVisible: Boolean;

    procedure SetControlAppearance()
    var
        myInt: Integer;
    begin
        if Rec.Status = Rec.Status::Open then
            OpenVisible := true
        else
            OpenVisible := false;
        if (Rec.Status = Rec.Status::Forwarded) then
            Officerisible := true
        else
            Officerisible := false;
        if (Rec.Status = Rec.Status::Closed) or (Rec.Status = Rec.Status::Receptionist) then
            ClosedVisible := true
        else
            ClosedVisible := false;
    end;
}
