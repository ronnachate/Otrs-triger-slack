package Kernel::System::Ticket::Event::NotificationEventTriggerSlack;
use Moose;

extends 'Kernel::System::Ticket::Event::NotificationEvent';

=head1 NAME

Kernel::System::Ticket::Event::NotificationEventTriggerSlack - wrapper fot notification triger ,try to triger slack api

=cut

around 'Run' => sub {
      my $orig = shift;
      my $self = shift;

      $result = $self->$orig(@_);
      #after send base notification and email
      if( $result ) {
            #send
            my $TicketObject = $Kernel::OM->Get('Kernel::System::Ticket');
            my $SlackClientObject = $Kernel::OM->Get('Kernel::System::Ticket::Event::NotificationEvent::Transport::SlackApi');
            $result = $SlackClientObject->SendNotification($TicketObject);
            if( $result ) {
                $result = 1;
            }
            else {
                $Kernel::OM->Get('Kernel::System::Log')->Log(
                    Priority => 'info',
                    Message  => "Call slack api error!",
                );
                return;
            }
      }
      #return what's we got from notification trigger.
      return $result;
};

1;
