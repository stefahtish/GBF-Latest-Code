page 50718 "CRM Escalation card"
{
    PageType = StandardDialog;
    SourceTable = "Client Interaction Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Interact Code"; Rec."Interact Code")
                {
                    Caption = 'No.';
                    ApplicationArea = All;
                }
                field(EscalationOption; EscalationOption)
                {
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        SetControlAppearance();
                    end;
                }
                field("New Escalator No."; Rec."New Escalator No.")
                {
                    Visible = InternalEsc;
                    Caption = 'Employee No.';
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Emp: Record Employee;
                        usersetup: Record "User Setup";
                    begin
                        Emp.SetRange("No.", Rec."New Escalator No.");
                        if Emp.FindFirst() then begin
                            EscalatorName := Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                            EscalationEmail := Emp."Company E-Mail";
                            usersetup.SetRange("Employee No.", Emp."No.");
                            if usersetup.FindFirst() then EscalatorUserID := usersetup."User ID";
                        end;
                    end;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                }
                field("Escalator Name"; EscalatorName)
                {
                    Enabled = ExtEsc;
                    Caption = 'Name';
                    ApplicationArea = All;
                }
                field("Escalation Email"; "EscalationEmail")
                {
                    Caption = 'Email';
                    ApplicationArea = All;
                }
                field(EscalationRemarks; EscalationRemarks)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
        }
    }
    var
        EscalationOption: Option "",Internal,External;
        EscalatorName: code[100];
        EscalatorUserID: Code[100];
        EscalationEmail: Text[100];
        EscalationNo: Code[100];
        InternalEsc: Boolean;
        ExtEsc: Boolean;
        EscUID: Code[50];
        InStrm: InStream;
        OutStrm: OutStream;
        EmailBigTxt: BigText;
        SMSBigTxt: BigText;
        EmailTxt: Text;
        EscalationRemarks: text[200];

    procedure SetControlAppearance()
    begin
        if EscalationOption = EscalationOption::Internal then
            InternalEsc := true
        else
            InternalEsc := false;
        if EscalationOption = EscalationOption::External then
            ExtEsc := true
        else
            ExtEsc := false;
    end;

    procedure GetNewDetails(var EscNo: Code[20]; var EscName: Code[100]; var EscEmail: Text[100]; var EscUID: Code[50]; var EscREmarks: Text[200])
    begin
        EscNo := Rec."New Escalator No.";
        EscName := EscalatorName;
        EscEmail := EscalationEmail;
        EscUID := EscalatorUserID;
        EscREmarks := EscalationRemarks;
    end;
}
